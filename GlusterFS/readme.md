# GlusterFS HA - Cluster Replicado con LVM

GlusterFS es un sistema de archivos distribuido de código abierto. Permite juntar el almacenamiento de varios servidores (nodos) en un solo volumen compartido, que los clientes ven y usan como si fuera un disco normal.

En este setup específico usamos el modo **Replica**: cada archivo que se escribe en el volumen se copia automáticamente en todos los nodos del cluster (bricks). Si un nodo se cae, el otro sigue sirviendo los datos sin interrupción, y cuando el nodo caído vuelve, GlusterFS sincroniza (self-heal) lo que se perdió.



Replica 2, LVM (PV/VG/LV), 2 nodos.

- Node1: `192.168.133.251`
- Node2: `192.168.133.252`
- Volumen: `vol1`
- Disco: `/dev/sdb`

## Referencia rápida (lo que cambia entre nodos)

| Paso | Node1 | Node2 |
|---|---|---|
| Peer probe | `gluster peer probe 192.168.133.252` | `gluster peer probe 192.168.133.251` |
| Crear volumen |  único lugar |  no se ejecuta aquí |
| Mount FUSE | `192.168.133.251:/vol1` | `192.168.133.252:/vol1` |

---

## NODE1 (192.168.133.251)

```bash
# Instalar
apt update && apt install -y lvm2 glusterfs-server
systemctl enable --now glusterd

# LVM
pvcreate /dev/sdb
vgcreate vg_gluster /dev/sdb
lvcreate -l 100%FREE -n lv_vol1 vg_gluster
mkfs.ext4 /dev/vg_gluster/lv_vol1

# Montar brick
mkdir -p /data/gluster/vol1
echo "/dev/vg_gluster/lv_vol1  /data/gluster/vol1  ext4  defaults  0 0" >> /etc/fstab
mount -a

# Peer
gluster peer probe 192.168.133.252
gluster peer status

# Crear volumen (SOLO AQUÍ)
gluster volume create vol1 replica 2 \
  192.168.133.251:/data/gluster/vol1 \
  192.168.133.252:/data/gluster/vol1 force
gluster volume start vol1

# Mount FUSE
mkdir -p /mnt/vol1
mount -t glusterfs 192.168.133.251:/vol1 /mnt/vol1
echo "192.168.133.251:/vol1  /mnt/vol1  glusterfs  defaults,_netdev  0 0" >> /etc/fstab
```

---

## NODE2 (192.168.133.252)

```bash
# Instalar
apt update && apt install -y lvm2 glusterfs-server
systemctl enable --now glusterd

# LVM
pvcreate /dev/sdb
vgcreate vg_gluster /dev/sdb
lvcreate -l 100%FREE -n lv_vol1 vg_gluster
mkfs.ext4 /dev/vg_gluster/lv_vol1

# Montar brick
mkdir -p /data/gluster/vol1
echo "/dev/vg_gluster/lv_vol1  /data/gluster/vol1  ext4  defaults  0 0" >> /etc/fstab
mount -a

# Peer
gluster peer probe 192.168.133.251
gluster peer status

# NO crear volumen aquí, ya se hizo en Node1

# Mount FUSE
mkdir -p /mnt/vol1
mount -t glusterfs 192.168.133.252:/vol1 /mnt/vol1
echo "192.168.133.252:/vol1  /mnt/vol1  glusterfs  defaults,_netdev  0 0" >> /etc/fstab
```

---

## Verificar (cualquier nodo)

```bash
gluster peer status
gluster volume status vol1
gluster volume heal vol1 info

# Prueba
touch /mnt/vol1/test.txt   # Node1
ls /mnt/vol1/              # Node2 -> debe aparecer
```

## Expandir storage

```bash
pvcreate /dev/sdc
vgextend vg_gluster /dev/sdc
lvextend -l +100%FREE /dev/vg_gluster/lv_vol1
resize2fs /dev/vg_gluster/lv_vol1
```

## Notas

- Escribe siempre en `/mnt/vol1` (mount), nunca en `/data/gluster/vol1` (brick directo).
- Replica 2 = riesgo de split-brain si se cae la red entre nodos y ambos escriben el mismo archivo. Para evitarlo: Replica 3 o Arbiter.
- IPs de este lab son DHCP — en producción usar IP estática.
