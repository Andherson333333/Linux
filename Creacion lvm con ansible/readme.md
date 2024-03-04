## Que es Ansible?
Ansible es una plataforma de automatización de TI de código abierto que simplifica las tareas de configuración, implementación y administración de sistemas. Utiliza un enfoque basado en la escritura de "playbooks" en YAML, lo que facilita la automatización de procesos en servidores y dispositivos de red

## Que es Physical Volumes(pvs)?
"pvs" se refiere a Physical Volumes en el contexto del Logical Volume Manager (LVM) de Linux. Un Physical Volume es una partición o disco completo que se utiliza como componente básico en LVM. Los Physical Volumes se agrupan en Grupos de Volúmenes (Volume Groups) para formar un espacio de almacenamiento lógico unificado.

## Que es un  Grupo de volúmenes(vgs)?

En el contexto de LVM, un Grupo de Volúmenes (Volume Group o VG) es una entidad que agrupa uno o más Physical Volumes en un conjunto único y lógico. Los Grupos de Volúmenes permiten crear y gestionar volúmenes lógicos, proporcionando flexibilidad en la asignación y redistribución de espacio de almacenamiento.

## Que es un  Volúmenes lógicos(lvm)?

Los Volúmenes Lógicos son unidades lógicas de almacenamiento creadas dentro de Grupos de Volúmenes. Se pueden considerar como particiones virtuales que pueden redimensionarse fácilmente sin afectar los datos existentes. Los Volúmenes Lógicos ofrecen flexibilidad y eficiencia en la gestión del espacio de almacenamiento en sistemas Linux que utilizan LVM.

![Diagrama]()

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


## Instalcion ansible
Esto va depender del sistema operativo que estemos usando , hay algunos como debian que tiene en el repositorio listo para la instalacion otros hay que instalarlo a traves de descarga para mas informacion por favor revisar el siguiente enlace https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html


## Creacion playbook con ansible galaxy

## Uso del playbook

