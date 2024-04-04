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


## Instalacion cliente 
