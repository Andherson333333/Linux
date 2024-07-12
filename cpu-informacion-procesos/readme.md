# CPU and Process Information in Linux

This repository contains useful information and commands to obtain CPU characteristics and monitor processes on Linux systems.

## Table of Contents
* [Before Using the Commands](#before-using-the-commands)
* [CPU Characteristic Commands](#cpu-characteristic-commands)
* [CPU Usage and Process Commands](#cpu-usage-and-process-commands)

## Before Using the Commands

Before executing CPU and process commands, it's recommended to verify two things:

### 1. Type of Operating System

You can use the following command:

```bash
lsb_release -a
```

![lsb_release output](https://github.com/Andherson333333/Linux/blob/main/cpu-informacion-procesos/imagenes/cpu-1.JPG)

If the above command is not available, you can use:

```bash
uname -a
```

![uname output](https://github.com/Andherson333333/Linux/blob/main/cpu-informacion-procesos/imagenes/cpu-3.2.JPG)

### 2. Check if there are other users on the server

```bash
w
```

![w command output](https://github.com/Andherson333333/Linux/blob/main/cpu-informacion-procesos/imagenes/cpu5.JPG)

## CPU Characteristic Commands

These commands will work on most operating systems, even on fresh installations without internet access.

### 1. lscpu

Provides detailed information about the CPU:

```bash
lscpu
```

![lscpu output](https://github.com/Andherson333333/Linux/blob/main/cpu-informacion-procesos/imagenes/cpu5.3.JPG)

To filter the most relevant information:

```bash
lscpu | grep -E 'Architecture|CPU op-mode|Thread\(s\) per core|Core\(s\) per socket|Model name|CPU MHz'
```

### 2. /proc/cpuinfo

```bash
cat /proc/cpuinfo
```

![/proc/cpuinfo output](https://github.com/Andherson333333/Linux/blob/main/cpu-informacion-procesos/imagenes/cpu-6.JPG)

### 3. dmidecode

```bash
dmidecode --type processor
```

![dmidecode output](https://github.com/Andherson333333/Linux/blob/main/cpu-informacion-procesos/imagenes/cpu-7.JPG)

## CPU Usage and Process Commands

### 1. top

Displays an interactive interface with information about CPU usage, memory, and processes in real-time.

```bash
top
```

![top output](https://github.com/Andherson333333/Linux/blob/main/cpu-informacion-procesos/imagenes/cpu8.JPG)

To exit, press the 'Q' key.

### 2. ps

Shows information about running processes. Some useful variations:

```bash
ps
ps -ef
ps -aux
ps -e -o pid,uname,pcpu,pmem,comm
```

![ps command example output](https://github.com/Andherson333333/Linux/blob/main/cpu-informacion-procesos/imagenes/cpu8.4.JPG)

### 3. vmstat

Provides information about virtual memory, processes, block I/O, traps, and CPU activity.

```bash
vmstat
```

![vmstat output](https://github.com/Andherson333333/Linux/blob/main/cpu-informacion-procesos/imagenes/cpu9.JPG)

## Contributions

Contributions to this project are welcome. Please open an issue or a pull request to suggest changes or improvements.

## License

[Include your license information here]
