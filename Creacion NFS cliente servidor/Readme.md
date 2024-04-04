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
Luego de eso hay que crear el directorio que deseas compartir , en este caso creare en `/storage` puede crearlo en la ruta que desea 

```
mkdir -p /storage
```
Ahora el ultimo paso es modificar el archivo `/etc/exports` que  contiene opciones de acceso que se aplicarán a esos directorios compartidos y estas son las opciones mas utilizadas :

- `rw (read-write)`modo lectura y escritura.
- `ro (read-only)`modo solo lectura
- `sync (synchronous)`operaciones de escritura en el sistema de archivos compartido deben realizarse de forma síncrona
- `async (asynchronous)`operaciones de escritura en el sistema de archivos compartido pueden realizarse de forma asíncrona
- `no_subtree_check`deshabilita la verificación de subárbo
- `all_squash`pción asigna todos los UID y GID a un usuario y grupo predeterminados en el servidor NFS




## Instalacion cliente 
