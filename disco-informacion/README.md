## ¿Ques es un disco duro?
Un disco duro es un dispositivo de almacenamiento de datos no volátil utilizado para guardar información digital de manera permanente en una computadora o servidor

## Tipos de disco duro
Discos duros HDD (Hard Disk Drive):on los más antiguos y comunes. Utilizan discos magnéticos para almacenar datos y tienen una velocidad de lectura y escritura relativamente lenta. Suelen tener una capacidad de almacenamiento mayor que otros tipos de discos duros. (5400 RPM o 7200 RPM)

Discos duros SSD (Solid State Drive):utilizan chips de memoria flash en lugar de discos magnéticos y no tienen partes móviles, lo que los hace más rápidos y resistentes a los golpes. Tienen una capacidad de almacenamiento menor que los discos duros HDD. (hasta 500 MB/s o más)

Discos duros SSHD (Solid State Hybrid Drive):combinan la tecnología de discos duros HDD y SSD en un solo dispositivo. Tienen una capacidad de almacenamiento mayor que los SSD y una velocidad de lectura y escritura más rápida que los HDD.

Discos duros SAS (Serial Attached SCSI):Discos duros SAS (Serial Attached SCSI): son discos duros de alta velocidad diseñados para su uso en servidores empresariales y sistemas de almacenamiento en red. (velocidad 15000 RPM)

Nota:Los discos sdd son mas rapido que los hdd 

## Evaluacion de los discos
Se puede decir en conclusion que podemos evaluar los disco en 2 funciones:

Almacenamiento

Velocidad 

## Comandos linux verificacion de almacenamiento

`lsblk`Este comando permite ver en un estructura de arbol de forma simplificada varias caracterisitcas entre ellas almacenamiento

```
lsblk
```
![Diagrama](https://github.com/Andherson333333/Linux/blob/main/disco-informacion/imagenes/lsblk-afuera.JPG)

![Diagrama]()

`df `Este comando te permite ver de forma estructura como se encuentra distribuido el espacio del disco entre las particiones de linux

```
df -h
```
![Diagrama](https://github.com/Andherson333333/Linux/blob/main/disco-informacion/imagenes/df%20-h.JPG)

`fdisk`Este comando es bastante potente ya que permite eliminar,crear formatiar particiones del disco y dar informacion es mas como una herramienta

```
fdisk -l
```
![Diagrama](https://github.com/Andherson333333/Linux/blob/main/disco-informacion/imagenes/fdisk-l%20-afuera.JPG)

## Comandos de linux para verificar velocidad del disco
```
hdparm -tT /dev/sda
```
![Diagrama](https://github.com/Andherson333333/Linux/blob/main/disco-informacion/imagenes/velocidad-1.JPG)

![Diagrama](https://github.com/Andherson333333/Linux/blob/main/disco-informacion/imagenes/velocidad-1%2C1.JPG)
```
iostat -d /dev/sda
```
![Diagrama](https://github.com/Andherson333333/Linux/blob/main/disco-informacion/imagenes/velocidad-2.JPG)

## Comandos de linux para verificar modelo del disco

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




