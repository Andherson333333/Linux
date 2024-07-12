# Disk Information in Linux

This repository contains information and commands for checking disk space, speed, and model in Linux systems.

## Table of Contents
* [What is a Hard Disk?](#what-is-a-hard-disk)
* [Types of Hard Disks](#types-of-hard-disks)
* [Disk Evaluation](#disk-evaluation)
* [Linux Commands for Storage Verification](#linux-commands-for-storage-verification)
* [Linux Commands for Disk Speed Verification](#linux-commands-for-disk-speed-verification)
* [Linux Commands for Disk Model Verification](#linux-commands-for-disk-model-verification)

## What is a Hard Disk?
A hard disk is a non-volatile data storage device used to permanently store digital information in a computer or server.

## Types of Hard Disks
1. **HDD (Hard Disk Drive)**: The oldest and most common. They use magnetic disks to store data and have relatively slow read and write speeds. They usually have a larger storage capacity than other types of hard drives. (5400 RPM or 7200 RPM)

2. **SSD (Solid State Drive)**: Use flash memory chips instead of magnetic disks and have no moving parts, making them faster and more shock-resistant. They have a lower storage capacity than HDD hard drives. (up to 500 MB/s or more)

3. **SSHD (Solid State Hybrid Drive)**: Combine HDD and SSD technology in a single device. They have a larger storage capacity than SSDs and faster read and write speeds than HDDs.

4. **SAS (Serial Attached SCSI)**: High-speed hard drives designed for use in enterprise servers and network storage systems. (15000 RPM speed)

Note: SSDs are faster than HDDs.

## Disk Evaluation
In conclusion, we can evaluate disks based on two main functions:
1. Storage
2. Speed

## Linux Commands for Storage Verification

### `lsblk`
This command allows you to view various characteristics, including storage, in a simplified tree structure.
```
lsblk
```
![Diagram](https://github.com/Andherson333333/Linux/blob/main/disco-informacion/imagenes/lsblk-afuera.JPG)

### `df`
This command allows you to view how disk space is distributed among Linux partitions in a structured way.
```
df -h
```
![Diagram](https://github.com/Andherson333333/Linux/blob/main/disco-informacion/imagenes/df%20-h.JPG)

### `fdisk`
This command is quite powerful as it allows you to delete, create, format disk partitions and provide information. It's more like a tool.
```
fdisk -l
```
![Diagram](https://github.com/Andherson333333/Linux/blob/main/disco-informacion/imagenes/fdisk-l%20-afuera.JPG)

## Linux Commands for Disk Speed Verification
```
hdparm -tT /dev/sda
```
![Diagram](https://github.com/Andherson333333/Linux/blob/main/disco-informacion/imagenes/velocidad-1.JPG)
![Diagram](https://github.com/Andherson333333/Linux/blob/main/disco-informacion/imagenes/velocidad-1%2C1.JPG)

```
iostat -d /dev/sda
```
![Diagram](https://github.com/Andherson333333/Linux/blob/main/disco-informacion/imagenes/velocidad-2.JPG)

## Linux Commands for Disk Model Verification
```
lshw -class disk
```
![Diagram](https://github.com/Andherson333333/Linux/blob/main/disco-informacion/imagenes/velocidad-3.JPG)

```
hdparm -I /dev/sda
```
![Diagram](https://github.com/Andherson333333/Linux/blob/main/disco-informacion/imagenes/modelo-2.JPG)

```
lsblk -o NAME,SIZE,VENDOR,MODEL
```
![Diagram](https://github.com/Andherson333333/Linux/blob/main/disco-informacion/imagenes/modelo-3.JPG)

## Quick Reference

### Disk Space Verification
```
lsblk
df -h 
fdisk -l
```

### Disk Speed Verification
```
hdparm -tT /dev/sda
iostat -d /dev/sda
```

### Disk Model Verification
```
lshw -class disk
hdparm -I /dev/sda
lsblk -o NAME,SIZE,VENDOR,MODEL
```

Feel free to contribute to this repository by adding more commands or improving the existing documentation!





