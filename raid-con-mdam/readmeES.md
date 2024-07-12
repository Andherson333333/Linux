# Configuración RAID con mdadm en Linux

Este repositorio contiene información y comandos para configurar y gestionar RAID (Redundant Array of Independent Disks) en sistemas Linux utilizando mdadm.

## Tabla de Contenidos
* [¿Qué es RAID?](#qué-es-raid)
* [RAID por Software vs Hardware](#raid-por-software-vs-hardware)
* [Tipos de RAID](#tipos-de-raid)
* [mdadm](#mdadm)
* [Verificación de Discos](#verificación-de-discos)
* [Instalación de mdadm](#instalación-de-mdadm)
* [Creación de RAID con mdadm](#creación-de-raid-con-mdadm)
* [Verificación de la Configuración](#verificación-de-la-configuración)
* [Configuración Permanente](#configuración-permanente)
* [Creación de un Sistema de Archivos a partir de este RAID](#creación-de-un-sistema-de-archivos-a-partir-de-este-raid)

## ¿Qué es RAID?
RAID (Redundant Array of Independent Disks) es una tecnología que combina múltiples componentes de unidades de disco en una unidad lógica para la redundancia de datos y la mejora del rendimiento. Las dos funciones principales son proteger los datos o aumentar la velocidad de acceso a los datos.

## RAID por Software vs Hardware
Hay dos formas de implementar RAID: a través de hardware o software.

1. Hardware: 
   Se puede hacer a través de la placa base (BIOS o UEFI dependiendo del caso) o mediante un controlador RAID (un dispositivo de hardware independiente).

2. Software:
   Se implementa sobre el sistema operativo, ya sea Linux o Windows.

## Tipos de RAID

- RAID 0 (2 discos): Especializado en aumentar la velocidad del disco combinando ambos discos.
- RAID 1 (2 discos): Especializado en escribir datos en ambos discos (espejo).
- RAID 5 (3 discos): Striping con paridad.
- RAID 6 (4 discos): Striping con paridad doble.
- RAID 10 (4 discos): Combina espejo y striping.

[Imágenes de los diferentes tipos de RAID disponibles en el repositorio]

## mdadm 
mdadm es una herramienta que permite crear y gestionar RAID en Linux.

## Verificación de Discos
Antes de comenzar la instalación, verifica que los discos sean visibles en tu sistema operativo:

```bash
lsblk
fdisk -l
```

## Instalación de mdadm

```bash
apt-get update
apt-get install mdadm
```

## Creación de RAID con mdadm

Verifica las configuraciones RAID existentes:
```bash
cat /proc/mdstat
```

Crea un RAID 0:
```bash
mdadm --create /dev/md0 --level=0 --raid-devices=2 /dev/sdb /dev/sdc --verbose
```

Crea un RAID 1:
```bash
mdadm --create /dev/md1 --level=1 --raid-devices=2 /dev/sdb /dev/sdc --verbose
```

## Verificación de la Configuración

```bash
cat /proc/mdstat
lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINT
fdisk -l /dev/md0 /dev/md1
```

## Configuración Permanente

Para hacer la configuración permanente:

1. Escanea el RAID:
   ```bash
   mdadm --detail --scan
   ```

2. Añade la configuración al archivo de configuración:
   ```bash
   mdadm --detail --scan >> /etc/mdadm/mdadm.conf
   ```

3. Verifica la configuración:
   ```bash
   cat /etc/mdadm/mdadm.conf | grep ARRAY
   ```

4. Actualiza initramfs:
   ```bash
   update-initramfs -u
   ```

## Creación de un Sistema de Archivos a partir de este RAID

1. Crea puntos de montaje:
   ```bash
   mkdir raid0 raid1
   ```

2. Formatea los discos RAID:
   ```bash
   mkfs.ext4 /dev/md0 && mkfs.ext4 /dev/md1
   ```

3. Configura los puntos de montaje en fstab:
   ```bash
   echo "/dev/md0 /raid0  ext4 defaults 1 2" >>/etc/fstab
   echo "/dev/md1 /raid1  ext4 defaults 1 2" >>/etc/fstab
   ```

4. Monta los sistemas de archivos:
   ```bash
   mount -a
   ```

5. Verifica el montaje:
   ```bash
   df -h
   ```

## Contribuciones

Las contribuciones a este proyecto son bienvenidas. Por favor, abre un issue o un pull request para sugerir cambios o mejoras.

## Licencia

[Incluye aquí la información de tu licencia]




