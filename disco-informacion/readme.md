# Información de Disco en Linux

Este repositorio contiene información y comandos para verificar el espacio, velocidad y modelo de discos en sistemas Linux.

## Índice de contenidos
* [¿Qué es un disco duro?](#qué-es-un-disco-duro)
* [Tipos de disco duro](#tipos-de-disco-duro)
* [Evaluación de los discos](#evaluación-de-los-discos)
* [Comandos de Linux para verificación de almacenamiento](#comandos-de-linux-para-verificación-de-almacenamiento)
* [Comandos de Linux para verificar velocidad del disco](#comandos-de-linux-para-verificar-velocidad-del-disco)
* [Comandos de Linux para verificar modelo del disco](#comandos-de-linux-para-verificar-modelo-del-disco)

## ¿Qué es un disco duro?
Un disco duro es un dispositivo de almacenamiento de datos no volátil utilizado para guardar información digital de manera permanente en una computadora o servidor.

## Tipos de disco duro
1. **Discos duros HDD (Hard Disk Drive)**: Son los más antiguos y comunes. Utilizan discos magnéticos para almacenar datos y tienen una velocidad de lectura y escritura relativamente lenta. Suelen tener una capacidad de almacenamiento mayor que otros tipos de discos duros. (5400 RPM o 7200 RPM)

2. **Discos duros SSD (Solid State Drive)**: Utilizan chips de memoria flash en lugar de discos magnéticos y no tienen partes móviles, lo que los hace más rápidos y resistentes a los golpes. Tienen una capacidad de almacenamiento menor que los discos duros HDD. (hasta 500 MB/s o más)

3. **Discos duros SSHD (Solid State Hybrid Drive)**: Combinan la tecnología de discos duros HDD y SSD en un solo dispositivo. Tienen una capacidad de almacenamiento mayor que los SSD y una velocidad de lectura y escritura más rápida que los HDD.

4. **Discos duros SAS (Serial Attached SCSI)**: Son discos duros de alta velocidad diseñados para su uso en servidores empresariales y sistemas de almacenamiento en red. (velocidad 15000 RPM)

Nota: Los discos SSD son más rápidos que los HDD.

## Evaluación de los discos
Se puede decir en conclusión que podemos evaluar los discos en 2 funciones:
1. Almacenamiento
2. Velocidad 

## Comandos de Linux para verificación de almacenamiento

### `lsblk`
Este comando permite ver en una estructura de árbol de forma simplificada varias características, entre ellas el almacenamiento.
```
lsblk
```
![Diagrama](https://github.com/Andherson333333/Linux/blob/main/disco-informacion/imagenes/lsblk-afuera.JPG)

### `df`
Este comando te permite ver de forma estructurada cómo se encuentra distribuido el espacio del disco entre las particiones de Linux.
```
df -h
```
![Diagrama](https://github.com/Andherson333333/Linux/blob/main/disco-informacion/imagenes/df%20-h.JPG)

### `fdisk`
Este comando es bastante potente ya que permite eliminar, crear y formatear particiones del disco, además de dar información. Es más como una herramienta.
```
fdisk -l
```
![Diagrama](https://github.com/Andherson333333/Linux/blob/main/disco-informacion/imagenes/fdisk-l%20-afuera.JPG)

## Comandos de Linux para verificar velocidad del disco
```
hdparm -tT /dev/sda
```
![Diagrama](https://github.com/Andherson333333/Linux/blob/main/disco-informacion/imagenes/velocidad-1.JPG)
![Diagrama](https://github.com/Andherson333333/Linux/blob/main/disco-informacion/imagenes/velocidad-1%2C1.JPG)

```
iostat -d /dev/sda
```
![Diagrama](https://github.com/Andherson333333/Linux/blob/main/disco-informacion/imagenes/velocidad-2.JPG)

## Comandos de Linux para verificar modelo del disco
```
lshw -class disk
```
![Diagrama](https://github.com/Andherson333333/Linux/blob/main/disco-informacion/imagenes/velocidad-3.JPG)

```
hdparm -I /dev/sda
```
![Diagrama](https://github.com/Andherson333333/Linux/blob/main/disco-informacion/imagenes/modelo-2.JPG)

```
lsblk -o NAME,SIZE,VENDOR,MODEL
```
![Diagrama](https://github.com/Andherson333333/Linux/blob/main/disco-informacion/imagenes/modelo-3.JPG)

## Referencia rápida

### Verificación de espacio en disco
```
lsblk
df -h 
fdisk -l
```

### Verificación de velocidad del disco
```
hdparm -tT /dev/sda
iostat -d /dev/sda
```

### Verificación del modelo de disco
```
lshw -class disk
hdparm -I /dev/sda
lsblk -o NAME,SIZE,VENDOR,MODEL
```

¡Siéntete libre de contribuir a este repositorio añadiendo más comandos o mejorando la documentación existente!
