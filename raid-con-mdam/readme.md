# RAID Configuration with mdadm in Linux

This repository contains information and commands to configure and manage RAID (Redundant Array of Independent Disks) on Linux systems using mdadm.

## Table of Contents
* [What is RAID?](#what-is-raid)
* [Software vs Hardware RAID](#software-vs-hardware-raid)
* [Types of RAID](#types-of-raid)
* [mdadm](#mdadm)
* [Disk Verification](#disk-verification)
* [Installing mdadm](#installing-mdadm)
* [Creating RAID with mdadm](#creating-raid-with-mdadm)
* [Configuration Verification](#configuration-verification)
* [Permanent Configuration](#permanent-configuration)
* [Creating a Filesystem from this RAID](#creating-a-filesystem-from-this-raid)

## What is RAID?
RAID (Redundant Array of Independent Disks) is a technology that combines multiple disk drive components into a logical unit for data redundancy and performance improvement. The two main functions are to protect data or increase data access speed.

## Software vs Hardware RAID
There are two ways to implement RAID: via hardware or software.

1. Hardware: 
   Can be done through the motherboard (BIOS or UEFI depending on the case) or through a RAID controller (an independent hardware device).

2. Software:
   Implemented on top of the operating system, either Linux or Windows.

## Types of RAID

### RAID 0 (2 disks)
Specializes in increasing disk speed by combining both disks. For example, if you have 2 disks at 3200 rpm, the combined speed would be 6400 rpm.

![RAID 0](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/raid-0.JPG)

### RAID 1 (2 disks)
Specializes in writing data to both disks (mirroring). The speed remains as if it were a single disk.

![RAID 1](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/radi-1.JPG)

### RAID 5 (3 disks)
Striping with parity. Unlike RAID 1, redundancy is done by disk sectors among the 3 disks.

![RAID 5](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/raid-5.JPG)

### RAID 6 (4 disks)
Striping with double parity.

![RAID 6](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/raid-6.JPG)

### RAID 10 (4 disks)
Also known as nested or combined RAID. It uses both mirroring and striping.

![RAID 10](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/raid-10.JPG)

## mdadm 
mdadm is a tool that allows you to create and manage RAID in Linux.

## Disk Verification
Before starting the installation, verify that the disks are visible in your operating system:

```bash
lsblk
fdisk -l
```

## Installing mdadm

```bash
apt-get update
apt-get install mdadm
```

## Creating RAID with mdadm

Verify existing RAID configurations:
```bash
cat /proc/mdstat
```

Create a RAID 0:
```bash
mdadm --create /dev/md0 --level=0 --raid-devices=2 /dev/sdb /dev/sdc --verbose
```

Create a RAID 1:
```bash
mdadm --create /dev/md1 --level=1 --raid-devices=2 /dev/sdb /dev/sdc --verbose
```

## Configuration Verification

```bash
cat /proc/mdstat
lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINT
fdisk -l /dev/md0 /dev/md1
```

## Permanent Configuration

To make the configuration permanent:

1. Scan the RAID:
   ```bash
   mdadm --detail --scan
   ```

2. Add the configuration to the configuration file:
   ```bash
   mdadm --detail --scan >> /etc/mdadm/mdadm.conf
   ```

3. Verify the configuration:
   ```bash
   cat /etc/mdadm/mdadm.conf | grep ARRAY
   ```

4. Update initramfs:
   ```bash
   update-initramfs -u
   ```

## Creating a Filesystem from this RAID

1. Create mount points:
   ```bash
   mkdir raid0 raid1
   ```

2. Format the RAID disks:
   ```bash
   mkfs.ext4 /dev/md0 && mkfs.ext4 /dev/md1
   ```

3. Configure the mount points in fstab:
   ```bash
   echo "/dev/md0 /raid0  ext4 defaults 1 2" >>/etc/fstab
   echo "/dev/md1 /raid1  ext4 defaults 1 2" >>/etc/fstab
   ```

4. Mount the filesystems:
   ```bash
   mount -a
   ```

5. Verify the mount:
   ```bash
   df -h
   ```

## Contributions

Contributions to this project are welcome. Please open an issue or a pull request to suggest changes or improvements.

## License

[Include your license information here]
