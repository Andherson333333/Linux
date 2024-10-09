# Creating LVM with Ansible

## Table of Contents
* [What is Ansible?](#what-is-ansible)
* [What are Physical Volumes (pvs)?](#what-are-physical-volumes-pvs)
* [What is a Volume Group (vgs)?](#what-is-a-volume-group-vgs)
* [What are Logical Volumes (lvm)?](#what-are-logical-volumes-lvm)
* [File Types](#file-types)
* [Ansible Installation](#ansible-installation)
* [Using Playbook to Create an LVM](#using-playbook-to-create-an-lvm)
* [Verification](#verification)

## What is Ansible?
Ansible is an open-source IT automation platform that simplifies configuration, deployment, and system management tasks. It uses a "playbook"-based approach written in YAML, making it easy to automate processes on servers and network devices.

## What are Physical Volumes (pvs)?
"pvs" refers to Physical Volumes in the context of Linux's Logical Volume Manager (LVM). A Physical Volume is a partition or complete disk used as a basic component in LVM. Physical Volumes are grouped into Volume Groups to form a unified logical storage space.

## What is a Volume Group (vgs)?
In the context of LVM, a Volume Group (VG) is an entity that groups one or more Physical Volumes into a single logical set. Volume Groups allow for the creation and management of logical volumes, providing flexibility in allocating and redistributing storage space.

## What are Logical Volumes (lvm)?
Logical Volumes are logical storage units created within Volume Groups. They can be considered as virtual partitions that can be easily resized without affecting existing data. Logical Volumes offer flexibility and efficiency in managing storage space on Linux systems using LVM.

![Diagram](https://github.com/Andherson333333/Linux/blob/main/Creacion%20lvm%20con%20ansible/imagenes/lvm-1.PNG)

## File Types
Many file format types can be used to create an LVM, but the most common is ext4.

Advantages:
- Wide Adoption
- Compatibility
- Advanced Journaling
- Support for Large Storage Volumes
- Improved Performance
- Advanced Features
- Compatibility with LVM Tools

## Ansible Installation
This will depend on the operating system you're using. Some, like Debian, have it ready in the repository for installation, while others require downloading it. For more information, please check the following link: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html

```
apt-get install ansible

```

## Using Playbook to Create an LVM

Requirements
- Verification of the added disk on the machine where the Filesystem will be created `lsblk`
- Verification through already established SSH keys https://github.com/Andherson333333/Linux/tree/main/configuracion-llaves-ssh

![Diagram](https://github.com/Andherson333333/Linux/blob/main/Creacion%20lvm%20con%20ansible/imagenes/lvm-2.PNG)

Once verified, we proceed to the master server where Ansible is installed, and we'll use 3 files

We have 3 files
- inventory (servers to include)
- modify_vars.sh (variables to modify)
- lvmcreate (directory) (Ansible execution)

![Diagram](https://github.com/Andherson333333/Linux/blob/main/Creacion%20lvm%20con%20ansible/imagenes/lvm-3.PNG)

We grant permissions and then execute the modify_vars.sh script

```
chmod +x modify_vars.sh
```

```
./modify_vars.sh
```

Once executed, it will show you the following screen

![Diagram](https://github.com/Andherson333333/Linux/blob/main/Creacion%20lvm%20con%20ansible/imagenes/lvm-4PNG.PNG)

We enter the necessary data

- `Note:` If you encounter an error with any character, you can go and modify the variables directly in the path /lvmcreate/vars/main.yml

We proceed to execute the playbook with the following command

```
ansible-playbook -i inventory lvmcreate/lvmcreate.yml
```

The following actions will be executed

- Update package cache
- Install lvm2
- Create Physical Volumes (PV)
- Create Volume Group (VG)
- Create Logical Volume (LV)
- Format the Logical Volume (LV)
- Create mount point and mount the LV
- Add entry to /etc/fstab file

## Verification

We go to the server where we created the filesystem and verify

```
lsblk
```

![Diagram](https://github.com/Andherson333333/Linux/blob/main/Creacion%20lvm%20con%20ansible/imagenes/lvm-6.PNG)

```
pvs && vgs && lvs
```

![Diagram](https://github.com/Andherson333333/Linux/blob/main/Creacion%20lvm%20con%20ansible/imagenes/lvm-7.PNG)

```
pvs && vgs && lvs
```
![Diagrama](https://github.com/Andherson333333/Linux/blob/main/Creacion%20lvm%20con%20ansible/imagenes/lvm-7.PNG)

```
cat /etc/fstab
```
![Diagrama](https://github.com/Andherson333333/Linux/blob/main/Creacion%20lvm%20con%20ansible/imagenes/lvm-8.PNG)
