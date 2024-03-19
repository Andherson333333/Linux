## Índice de contenidos
* [Uso de este repositorio](#item1)
* [Que es ansible](#item2)
* [Creacion y borrado de usuarios](#item3)
* [](#item4)


# Uso de este repositorio

En este caso hay 2 playbook de ansible uno para crear usuarios y otro para borrarlos

## Que es ansible

Ansible es una plataforma de automatización de TI de código abierto que simplifica las tareas de configuración, implementación y administración de sistemas. Utiliza un enfoque basado en la escritura de "playbooks" en YAML, lo que facilita la automatización de procesos en servidores y dispositivos de red

## Creacion y borrado de usuarios

Para crear usuarios en Linux, generalmente se utilizan dos comandos: `adduser `y `useradd`. En cambio, para eliminar usuarios, se suelen emplear los comandos `userdel` y `deluser`. Sin embargo, este proceso se realiza de forma individual en cada servidor, lo que significa que debe repetirse en cada uno de ellos. En cambio con ansible se puede realizar en muchos servidores al mismo tiempo permitiendo un control y mandejo mas facil .


## Creacion de usuarios con ansible

`Nota:` Para utilizar Ansible, es necesario haber establecido previamente una conexión mediante una llave SSH y tener los permisos suficientes en el servidor.

Este playbook se encarga de crear usuarios con clave generica que esta en la ruta `creacion-user/vars/main.yml` si quieres colocar otra clave puede cambiarlo. Cabe destacar que el contenido de la clave tiene que ser cifrado compatible con `/etc/shadow` que este usando . Tambien tiene la funcion de que al crear usuario se lanza automaticamente el comando `chage -d 0` para que al entrar al uusario cambie la clave automaticamente

![Diagrama](https://github.com/Andherson333333/Linux/blob/main/Creacion%20usuarios%20con%20ansible/imagenes/creacion-1.png)

Una ves verificada la informacion modifique el archivo `inventory` con la ip de los servidores que desar crear el usuario . 

![Diagrama](https://github.com/Andherson333333/Linux/blob/main/Creacion%20usuarios%20con%20ansible/imagenes/creacion-2.png)

Luego de la modicacion puede puede usar playbook con el siguiente comando

```
ansible-playbook -i inventory creacion-user/creacion-user.yml
```
![Diagrama](https://github.com/Andherson333333/Linux/blob/main/Creacion%20usuarios%20con%20ansible/imagenes/creacion-3.png)

Para verificar vamos al servidor donde se aplico la creacion del usuario

![Diagrama](https://github.com/Andherson333333/Linux/blob/main/Creacion%20usuarios%20con%20ansible/imagenes/verificacion-1.png)

Ahora vericaremos el cambio del clave al entrar al usuario (password=test)

![Diagrama](https://github.com/Andherson333333/Linux/blob/main/Creacion%20usuarios%20con%20ansible/imagenes/verificacion-2.png)










