## Índice de contenidos
* [¿Que es un raid?](#item1)
* [Raid por software o hardware](#item2)
* [Tipos de raid](#item3)
* [Mdam](#item4)
* [ Verificacion de discos](#item5)
* [Instalacion del mdamm](#item6)
* [Creacion del raid con mdam](#item7)
* [Verificacion de configuracion](#item8)
* [Configuracion de forma permanente](#item9)
* [Creacion de un filesystem a partir de esta raid](#item10)



<a name="item1"></a>
## ¿Que es un raid?
Raid (Redundant Array of Independent Disks) en Matriz Redundante de Discos Independientes, en pocas palabras son arreglos de discos para diferentes funciones,
las 2 principales serian proteger o dar mas velocidad a los datos .

<a name="item2"></a>
## Raid por software o hardware
Hay 2 formas de hacer una raid por hardware o por software

1 hardware 
Puede hacerlo a traves de la placa base (bios o uefi dependiendo caso) o tambien hacerlo a traves de una controladora RAID (Es un hardware independiente)

2 software
Se hace arriba del sistema operativo ya sea linux o windows 

<a name="item3"></a>
## Tipos de raid

RAID 0(2 discos): división de datos se especializa en aumentar la velocidad del disco combinando ambos discos. Ejemplo si tienes 2 discos 3200 rpm + 3200 rpm = 6400 rpm 
 
![Diagrama](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/raid-0.JPG)

RAID 1 (2 discos): duplicación de datos se especializa en escribri los datos en ambos discos pero , pero la velicdiad se matiene como si fuera 1 solo disco

![Diagrama](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/radi-1.JPG)

(Pariedad capacidad que tiene el un disco para tomar espacio en otros discos para reconstruir si un disco de ellos fallas)

RAID 5(3 discos) : creación de bandas con verificación de paridad , a diferencias de raid 1 es que cuando la redundancia lo hace por sectores del disco entre los 3 discos (en la imagen )

![Diagrama](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/raid-5.JPG)

RAID 6(4 discos): creación de bandas con verificación de paridad doble (4 discos)

![Diagrama](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/raid-6.JPG)

RAID 10(raid anidados o combinados 4 discos): utiliza tanto la duplicación como la creación de bandas

![Diagrama](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/raid-10.JPG)

<a name="item4"></a>
## Mdam 
mdam es una herramienta que permite hacer raid en linux 

<a name="item5"></a>
## Verificacion de discos
Antes de empezar a instalar verfique que los discos se vean en su sistea operativo , puede usar varios comandos para eso

```
lsblk
```
![Diagrama](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/lsblk.JPG)
o tambien 

```
fdisk -l
```
![Diagrama](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/fdisk-l.JPG)

<a name="item6"></a>
## Instalacion del mdam

verificar que tiene los repositorios funcionando 

```
apt-get update
```
![Diagrama](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/apt-get-update.JPG)

luego 

```
apt-get install mdadm
```
![Diagrama](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/apt-get-install-mdam.JPG)

<a name="item7"></a>
## Creacion del raid con mdam

al darle cat al siguiente archivo te desplegara los tipso configuraciones que se puede realizar y si hay algun raid activo

![Diagrama](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/cat-mdstat-1.JPG)

Para crear el raid se hace solo a trave de un comando que esta compuesto por las siguientes partes :

`mdadm --create /dev/md0`Creacion de nombre del disco RAID md0 (md1,md2,md3 si el md0 esta ocupado o lo ocupa otro raid procegir con el 1 ,2,3,4 ect)

`level=1`Esto es para asegurarse de que sea RAID 1 (esto son las opciones del personalities)

`raid devices=2`Este comando especifica el numero de particiones que va usar para hacer el raid(sdb,sdc)

`verbose`para que al crear el raid genere la informacion del proceso

ok una ves estudiado la sintanxis procederemos a lanzar el comando

```
mdadm --create /dev/md0 --level=0 --raid-devices=2 /dev/sdb /dev/sdc --verbose
```
```
mdadm --create /dev/md1 --level=1 --raid-devices=2 /dev/sdb /dev/sdc --verbose
```
<a name="item8"></a>
## Verificacion de configuracion

Una ves aplicado el comando se puede verificar si funciono de 3 maneras :

```
cat /proc/mdstat
```
![Diagrama](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/verificaicon-1.JPG)
```
fdisk -l /dev/md0 /dev/md1
```
![Diagrama](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/verificacion-2.JPG)
```
lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINT
```
![Diagrama](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/verificacion-3.JPG)

<a name="item9"></a>
## Configuracion de forma permanente

Si reincia el servidor de esta forma todo las configuraciones se perderan , para realizar de forma permanente esta configuracion se realiza con solo 3 comandos:

1  Scaniar el raid

```
mdadm --detail --scan
```
![Diagrama](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/permanente-scan.JPG)

2 Manda esa salida de comando al archivo de configuracion

```
mdadm --detail --scan >> /etc/mdadm/mdadm.conf
```
![Diagrama](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/permanete-add.JPG)

Verificamos que se copio el archivo correctamente

```
cat /etc/mdadm/mdadm.conf | grep ARRAY
```

![Diagrama](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/permanente-verificaicon.JPG)

3 Actualizacion de los initramfs (arraque sistema)

```
update-initramfs -u
```
![Diagrama](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/permanente-initfra.JPG)

<a name="item10"></a>
## Creacion de un filesystem a partir de esta raid

(En este caso no se va a crear un vg si no directamente un filesystem)

Creamos el punto de mountura de los filesystem (en este caso se crear en la ruta /)

```
mkdir raid0 
```
```
mkdir raid1 
```
Una ves creado procedemso a darle formato a los discos md0 y md1

```
mkfs.ext4 /dev/md0 && mkfs.ext4 /dev/md1
```
![Diagrama](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/fs-formato.JPG)


Luego escribimos en el fstab los puntos de montura correspondiente

```
echo "/dev/md0 /raid0  ext4 defaults 1 2" >>/etc/fstab
```

```
echo "/dev/md1 /raid1  ext4 defaults 1 2" >>/etc/fstab

```
Verificamos si se monto correctamente

```
cat /etc/fstab | grep -E '/dev/md0|/dev/md1'
```
![Diagrama](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/fstab.JPG)


y por ultimo montamos el filesystem con el comando

```
mount -a
```
Verificacamos que funcione

```
df -h
```

![Diagrama](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/fs-df.JPG)

y luego solo creamos algunos archivos para ver si escribe

![Diagrama](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/fs-verificacion.JPG)






