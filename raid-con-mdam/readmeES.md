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

### RAID 0 (2 discos)
Especializado en aumentar la velocidad del disco combinando ambos discos. Por ejemplo, si tienes 2 discos de 3200 rpm, la velocidad combinada sería de 6400 rpm.

![RAID 0](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/raid-0.JPG)

### RAID 1 (2 discos)
Especializado en escribir datos en ambos discos (espejo). La velocidad se mantiene como si fuera un solo disco.

![RAID 1](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/radi-1.JPG)

### RAID 5 (3 discos)
Striping con paridad. A diferencia de RAID 1, la redundancia se hace por sectores del disco entre los 3 discos.

![RAID 5](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/raid-5.JPG)

### RAID 6 (4 discos)
Striping con paridad doble.

![RAID 6](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/raid-6.JPG)

### RAID 10 (4 discos)
También conocido como RAID anidado o combinado. Utiliza tanto la duplicación (espejo) como la creación de bandas (striping).

![RAID 10](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/raid-10.JPG)

## mdadm 
mdadm es una herramienta que permite crear y gestionar RAID en Linux.

[El resto del contenido permanece igual...]



