
## ¿Que es un raid?
Raid (Redundant Array of Independent Disks) en Matriz Redundante de Discos Independientes, en pocas palabras son arreglos de discos para diferentes funciones,
las 2 principales serian proteger o dar mas velocidad a los datos .

## Raid por software o hardware
Hay 2 formas de hacer una raid por hardware o por software

1 hardware 
Puede hacerlo a traves de la placa base (bios o uefi dependiendo caso) o tambien hacerlo a traves de una controladora RAID (Es un hardware independiente)

2 software
Se hace arriba del sistema operativo ya sea linux o windows 


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









