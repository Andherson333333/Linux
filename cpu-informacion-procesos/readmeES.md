# Información de CPU y Procesos en Linux

Este repositorio contiene información y comandos útiles para obtener características de la CPU y monitorear procesos en sistemas Linux.

## Índice de contenidos
* [Antes de los comandos](#antes-de-los-comandos)
* [Comandos de características CPU](#comandos-de-características-cpu)
* [Comandos de uso de CPU y procesos](#comandos-de-uso-de-cpu-y-procesos)

## Antes de los comandos

Antes de ejecutar los comandos de CPU y procesos, es recomendable verificar dos cosas:

### 1. Tipo de sistema operativo

Puedes usar el siguiente comando:

```bash
lsb_release -a
```

![Salida de lsb_release](https://github.com/Andherson333333/Linux/blob/main/cpu-informacion-procesos/imagenes/cpu-1.JPG)

Si el comando anterior no está disponible, puedes usar:

```bash
uname -a
```

![Salida de uname](https://github.com/Andherson333333/Linux/blob/main/cpu-informacion-procesos/imagenes/cpu-3.2.JPG)

### 2. Verificar si hay otros usuarios en el servidor

```bash
w
```

![Salida del comando w](https://github.com/Andherson333333/Linux/blob/main/cpu-informacion-procesos/imagenes/cpu5.JPG)

## Comandos de características CPU

Estos comandos funcionarán en la mayoría de los sistemas operativos, incluso en instalaciones recientes sin acceso a internet.

### 1. lscpu

Proporciona información detallada sobre la CPU:

```bash
lscpu
```

![Salida de lscpu](https://github.com/Andherson333333/Linux/blob/main/cpu-informacion-procesos/imagenes/cpu5.3.JPG)

Para filtrar la información más relevante:

```bash
lscpu | grep -E 'Architecture|CPU op-mode|Thread\(s\) per core|Core\(s\) per socket|Model name|CPU MHz'
```

### 2. /proc/cpuinfo

```bash
cat /proc/cpuinfo
```

![Salida de /proc/cpuinfo](https://github.com/Andherson333333/Linux/blob/main/cpu-informacion-procesos/imagenes/cpu-6.JPG)

### 3. dmidecode

```bash
dmidecode --type processor
```

![Salida de dmidecode](https://github.com/Andherson333333/Linux/blob/main/cpu-informacion-procesos/imagenes/cpu-7.JPG)

## Comandos de uso de CPU y procesos

### 1. top

Muestra una interfaz interactiva con información sobre el uso de CPU, memoria y procesos en tiempo real.

```bash
top
```

![Salida de top](https://github.com/Andherson333333/Linux/blob/main/cpu-informacion-procesos/imagenes/cpu8.JPG)

Para salir, presiona la tecla 'Q'.

### 2. ps

Muestra información sobre los procesos en ejecución. Algunas variaciones útiles:

```bash
ps
ps -ef
ps -aux
ps -e -o pid,uname,pcpu,pmem,comm
```

![Ejemplo de salida de ps](https://github.com/Andherson333333/Linux/blob/main/cpu-informacion-procesos/imagenes/cpu8.4.JPG)

### 3. vmstat

Proporciona información sobre la memoria virtual, procesos, bloques I/O, traps y actividad de CPU.

```bash
vmstat
```

![Salida de vmstat](https://github.com/Andherson333333/Linux/blob/main/cpu-informacion-procesos/imagenes/cpu9.JPG)

## Contribuciones

Las contribuciones a este proyecto son bienvenidas. Por favor, abre un issue o un pull request para sugerir cambios o mejoras.

## Licencia

[Incluye aquí la información de tu licencia]
