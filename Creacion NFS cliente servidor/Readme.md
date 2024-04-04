## Que es un nfs ?

NFS, que significa Network File System (Sistema de Archivos en Red), es un protocolo de comunicación que permite a los sistemas informáticos compartir archivos y recursos de almacenamiento en una red.

El NFS permite que un sistema acceda y monte los archivos almacenados en otro sistema remoto como si fueran archivos locales. Esto facilita la colaboración y el intercambio de datos entre múltiples usuarios y sistemas en una red. El protocolo NFS se basa en el modelo cliente-servidor, donde el servidor de archivos almacena y gestiona los archivos, mientras que los clientes pueden acceder a estos archivos a través de la red.

## Instalacion servidor nfs 

Son 3 pasos:

- Instalar paquetes nfs
- Crear punto montura
- Configurar el  `/etc/exports`

Para instalar un nfs en un servidor debian hay que tener acceso al repositorio m una ves verificado conecion al mismo se usan los siguientes comandos 

```
sudo apt update
sudo apt install nfs-kernel-server
```
Luego de eso hay que crear el directorio que deseas compartir , en este caso creare en `/storage` puede crearlo en la ruta que desea , cabe destacar que se crean con los permisos nobody:nogroup pro seguridad

```
mkdir -p /storage
chown -R nobody:nogroup /storage/ 
```
Ahora el ultimo paso es modificar el archivo `/etc/exports` que  contiene opciones de acceso que se aplicarán a esos directorios compartidos y estas son las opciones mas utilizadas :

- `rw (read-write)`modo lectura y escritura.
- `ro (read-only)`modo solo lectura
- `sync (synchronous)`operaciones de escritura en el sistema de archivos compartido deben realizarse de forma síncrona
- `async (asynchronous)`operaciones de escritura en el sistema de archivos compartido pueden realizarse de forma asíncrona
- `no_subtree_check`deshabilita la verificación de subárbo
- `all_squash`pción asigna todos los UID y GID a un usuario y grupo predeterminados en el servidor NFS

Una ves verificada la opciones que desea utilizar se configura el archivo `nano /etc/exports` 
  
![Diagrama](https://github.com/Andherson333333/Linux/blob/main/Creacion%20NFS%20cliente%20servidor/imagenes/nfs-1.png)


## Instalacion cliente nfs

Son 3 pasos :

- Instalar paquetes nfs
- Crear punto montura
- Montar el sistema de archivos compartido e incluirlo al `/etc/fstab`

Para instalar un nfs en un servidor debian hay que tener acceso al repositorio m una ves verificado conecion al mismo se usan los siguientes comandos 

```
sudo apt update
sudo apt install nfs-common
```
yo lo creare con la misma ruta y nombre pero sin los permisos `nobody:nogroup` 

```
mkdir -p /storage
```

Ahora para montar el nfs la estructura del comando se veria asi:

`mount -t nfs IP_SERVIDOR:/ruta/al/directorio/compartido /mnt/nfs_share`

- `mount` Este es el comando utilizado en sistemas Unix/Linux para montar un sistema de archivos
- `-t nfs`que el tipo de sistema de archivos que se va a montar es de tipo NFS (Network File System)
- `IP_SERVIDOR:/ruta/al/directorio/compartido`Esta es la especificación del origen del sistema de archivos que se va a montar. Aquí se indica la dirección IP del servidor NFS (IP_SERVIDOR) y la ruta completa del directorio compartido en el servidor
- `/mnt/nfs_share`ste es el punto de montaje, es decir, la ubicación en el sistema de archivos local donde se montará el sistema de archivos NFS. En este caso, se está montando en el directorio /mnt/nfs_share.

Una ves estructurado vamos lanzarlo 

```
mount -t nfs 192.168.80.137:/storage /storage
```

Luego procederemos a colocarlo en la ruta `/etc/fstab` para que cuando servidor inicie autmaticamente monte el nfs 

```
echo "192.168.80.137:/storage /storage nfs defaults 0 0" | sudo tee -a /etc/fstab
```

Verificamos con el comando `df -h `

![Diagrama](https://github.com/Andherson333333/Linux/blob/main/Creacion%20NFS%20cliente%20servidor/imagenes/nfs-2.png)








