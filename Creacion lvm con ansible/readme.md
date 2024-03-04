## Índice de contenidos
* [Generar la llave RSA](#item1)
* [Ubicacion de la llaves generadas](#item2)
* [Ultimo paso](#item3)
* [Ahora que ¿pasa en el servidor destino?](#item4)


<a name="item1"></a>
## Que es Ansible?
Ansible es una plataforma de automatización de TI de código abierto que simplifica las tareas de configuración, implementación y administración de sistemas. Utiliza un enfoque basado en la escritura de "playbooks" en YAML, lo que facilita la automatización de procesos en servidores y dispositivos de red

<a name="item2"></a>
## Que es Physical Volumes(pvs)?
"pvs" se refiere a Physical Volumes en el contexto del Logical Volume Manager (LVM) de Linux. Un Physical Volume es una partición o disco completo que se utiliza como componente básico en LVM. Los Physical Volumes se agrupan en Grupos de Volúmenes (Volume Groups) para formar un espacio de almacenamiento lógico unificado.

<a name="item3"></a>
## Que es un  Grupo de volúmenes(vgs)?

En el contexto de LVM, un Grupo de Volúmenes (Volume Group o VG) es una entidad que agrupa uno o más Physical Volumes en un conjunto único y lógico. Los Grupos de Volúmenes permiten crear y gestionar volúmenes lógicos, proporcionando flexibilidad en la asignación y redistribución de espacio de almacenamiento.

<a name="item4"></a>
## Que es un  Volúmenes lógicos(lvm)?

Los Volúmenes Lógicos son unidades lógicas de almacenamiento creadas dentro de Grupos de Volúmenes. Se pueden considerar como particiones virtuales que pueden redimensionarse fácilmente sin afectar los datos existentes. Los Volúmenes Lógicos ofrecen flexibilidad y eficiencia en la gestión del espacio de almacenamiento en sistemas Linux que utilizan LVM.

![Diagrama](https://github.com/Andherson333333/Linux/blob/main/Creacion%20lvm%20con%20ansible/imagenes/lvm-1.PNG)

<a name="item5"></a>
## Tipos de archivos

Se puede trabajar con muchos tipos de formato de archivos para crear un LVM pero el mas comun es ext4 .

Ventajas:
- Amplia Adopción
- Compatibilidad
- Journaling Avanzado
- Soporte para Grandes Volúmenes de Almacenamiento
- Rendimiento Mejorado
- Funcionalidades Avanzadas
- Compatibilidad con Herramientas LVM

<a name="item6"></a>
## Instalcion ansible
Esto va depender del sistema operativo que estemos usando , hay algunos como debian que tiene en el repositorio listo para la instalacion otros hay que instalarlo a traves de descarga para mas informacion por favor revisar el siguiente enlace https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html

```
apt-get install ansible
```

<a name="item7"></a>
## Uso playbook para crear un lvm

Requisitos 
- Verificacion del disco agregado en la maquina donde se creara el Filesystem `lsblk`
- Verificacion de a traves de llaves ssh ya establecidas https://github.com/Andherson333333/Linux/tree/main/configuracion-llaves-ssh

![Diagrama](https://github.com/Andherson333333/Linux/blob/main/Creacion%20lvm%20con%20ansible/imagenes/lvm-2.PNG)

Una ves verificado procedemos al servidor master donde esta instalado en ansible y vamos usar 3 archivos

Tenemos 3 archivos 
- inventory (servidores a incluir)
- modify_vars.sh (variables a modificar )
- lvmcreate (directorio) (ejecuacion del ansible)

![Diagrama](https://github.com/Andherson333333/Linux/blob/main/Creacion%20lvm%20con%20ansible/imagenes/lvm-3.PNG)

Le damos permisos y luego ejecutamos el scrip modify_vars.sh 

```
chmod +x modify_vars.sh
```

```
./modify_vars.sh
```

Una ves ejecutado les mostrara la siguiente pantalla 

![Diagrama](https://github.com/Andherson333333/Linux/blob/main/Creacion%20lvm%20con%20ansible/imagenes/lvm-4PNG.PNG)

Metemos los datos necesarios 

- `Nota:` Si presenta error en algun caracter puede ir y modificar las variables directamente en la ruta /lvmcreate/vars/main.yml

Procedemso a ejecutar el playbook con el siguiente comando 

```
ansible-playbook -i inventory lvmcreate/lvmcreate.yml
```
Se ejecutaran las siguiente acciones

-  Actualizar caché de paquetes
-  Instalar lvm2
-  Crear Physical Volumes (PV)
-  Crear Volume Group (VG)
-  Crear Logical Volume (LV)
-   Formatear el Logical Volume (LV)
-   Crear punto de montaje y montar el LV
-   Agregar entrada al archivo /etc/fstab

<a name="item8"></a>
## Verificacion 

Nos dirijimos al servidor donde creamos el filesystem y verificamos

```
lsblk
```
![Diagrama](https://github.com/Andherson333333/Linux/blob/main/Creacion%20lvm%20con%20ansible/imagenes/lvm-6.PNG)

```
pvs && vgs && lvs
```
![Diagrama](https://github.com/Andherson333333/Linux/blob/main/Creacion%20lvm%20con%20ansible/imagenes/lvm-7.PNG)

```
cat /etc/fstab
```
![Diagrama](https://github.com/Andherson333333/Linux/blob/main/Creacion%20lvm%20con%20ansible/imagenes/lvm-8.PNG)












