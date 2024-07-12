## Table of Contents
* [What is RAID?](#item1)
* [Software vs Hardware RAID](#item2)
* [Types of RAID](#item3)
* [mdadm](#item4)
* [Disk Verification](#item5)
* [Installing mdadm](#item6)
* [Creating RAID with mdadm](#item7)
* [Configuration Verification](#item8)
* [Permanent Configuration](#item9)
* [Creating a Filesystem from this RAID](#item10)

<a name="item1"></a>
## What is RAID?
RAID (Redundant Array of Independent Disks) is a technology that combines multiple disk drive components into a logical unit for data redundancy and performance improvement. The two main functions are to protect data or increase data access speed.

<a name="item2"></a>
## Software vs Hardware RAID
There are two ways to implement RAID: via hardware or software.

1. Hardware 
   Can be done through the motherboard (BIOS or UEFI depending on the case) or through a RAID controller (an independent hardware device).

2. Software
   Implemented on top of the operating system, either Linux or Windows.

<a name="item3"></a>
## Types of RAID

RAID 0 (2 disks): Data striping specializes in increasing disk speed by combining both disks. For example, if you have 2 disks at 3200 rpm + 3200 rpm = 6400 rpm 
 
![Diagram](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/raid-0.JPG)

RAID 1 (2 disks): Data mirroring specializes in writing data to both disks, but the speed remains as if it were a single disk.

![Diagram](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/radi-1.JPG)

(Parity is the ability of a disk to use space on other disks to reconstruct if one of them fails)

RAID 5 (3 disks): Striping with parity. Unlike RAID 1, redundancy is done by disk sectors among the 3 disks (in the image)

![Diagram](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/raid-5.JPG)

RAID 6 (4 disks): Striping with double parity (4 disks)

![Diagram](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/raid-6.JPG)

RAID 10 (nested or combined RAID, 4 disks): Uses both mirroring and striping

![Diagram](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/raid-10.JPG)

<a name="item4"></a>
## mdadm 
mdadm is a tool that allows you to create and manage RAID in Linux.

<a name="item5"></a>
## Disk Verification
Before starting the installation, verify that the disks are visible in your operating system. You can use several commands for this:

```
lsblk
```
![Diagram](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/lsblk.JPG)
or also 

```
fdisk -l
```
![Diagram](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/fdisk-l.JPG)

<a name="item6"></a>
## Installing mdadm

Verify that the repositories are working:

```
apt-get update
```
![Diagram](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/apt-get-update.JPG)

Then:

```
apt-get install mdadm
```
![Diagram](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/apt-get-install-mdam.JPG)

<a name="item7"></a>
## Creating RAID with mdadm

Displaying the following file will show the types of configurations that can be performed and if there is any active RAID:

![Diagram](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/cat-mdstat-1.JPG)

To create the RAID, use a command composed of the following parts:

`mdadm --create /dev/md0`: Creation of RAID disk name md0 (md1, md2, md3 if md0 is occupied or used by another RAID, proceed with 1, 2, 3, 4, etc.)

`level=1`: This is to ensure it's RAID 1 (these are the personality options)

`raid-devices=2`: This command specifies the number of partitions to use for the RAID (sdb, sdc)

`verbose`: To generate process information when creating the RAID

Once the syntax is understood, we'll proceed to launch the command:

```
mdadm --create /dev/md0 --level=0 --raid-devices=2 /dev/sdb /dev/sdc --verbose
```
```
mdadm --create /dev/md1 --level=1 --raid-devices=2 /dev/sdb /dev/sdc --verbose
```

<a name="item8"></a>
## Configuration Verification

Once the command is applied, you can verify if it worked in 3 ways:

```
cat /proc/mdstat
```
![Diagram](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/verificaicon-1.JPG)
```
fdisk -l /dev/md0 /dev/md1
```
![Diagram](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/verificacion-2.JPG)
```
lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINT
```
![Diagram](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/verificacion-3.JPG)

<a name="item9"></a>
## Permanent Configuration

If you restart the server, all configurations will be lost. To make this configuration permanent, use these 3 commands:

1. Scan the RAID:

```
mdadm --detail --scan
```
![Diagram](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/permanente-scan.JPG)

2. Send that command output to the configuration file:

```
mdadm --detail --scan >> /etc/mdadm/mdadm.conf
```
![Diagram](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/permanete-add.JPG)

Verify that the file was copied correctly:

```
cat /etc/mdadm/mdadm.conf | grep ARRAY
```

![Diagram](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/permanente-verificaicon.JPG)

3. Update initramfs (system boot):

```
update-initramfs -u
```
![Diagram](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/permanente-initfra.JPG)

<a name="item10"></a>
## Creating a Filesystem from this RAID

(In this case, we won't create a vg but directly a filesystem)

Create the mount point for the filesystems (in this case, created in the / path):

```
mkdir raid0 
```
```
mkdir raid1 
```
Once created, we proceed to format the md0 and md1 disks:

```
mkfs.ext4 /dev/md0 && mkfs.ext4 /dev/md1
```
![Diagram](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/fs-formato.JPG)

Then we write the corresponding mount points in fstab:

```
echo "/dev/md0 /raid0  ext4 defaults 1 2" >>/etc/fstab
```

```
echo "/dev/md1 /raid1  ext4 defaults 1 2" >>/etc/fstab

```
Verify if it's mounted correctly:

```
cat /etc/fstab | grep -E '/dev/md0|/dev/md1'
```
![Diagram](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/fstab.JPG)

Finally, mount the filesystem with the command:

```
mount -a
```
Verify that it works:

```
df -h
```

![Diagram](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/fs-df.JPG)

Then just create some files to see if it writes:

![Diagram](https://github.com/Andherson333333/Linux/blob/main/raid-con-mdam/imagenes/fs-verificacion.JPG)
