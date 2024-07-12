## Table of Contents
* [What is Linux?](#item1)
* [What is open-source?](#item2)
* [What are distros?](#item3)
* [Linux System Structure](#item4)
* [File Structure](#item5)

<a name="item1"></a>
## What is Linux?

Linux is a Unix-like operating system characterized by being open-source and free. Its kernel was created by Linus Torvalds and is maintained by a large community of developers. Unlike other operating systems, Linux allows users to access and modify its source code, which encourages collaboration and adaptation to various needs.

This operating system stands out for its stability, security, and efficiency in server environments, but it's also used in embedded systems, personal computers, and other devices.

As is known, Linux is a monolithic system that relies on the kernel to control most of the system.

![Diagram](https://github.com/Andherson333333/Linux/blob/main/estructura%20linux/imanges/linux-1.PNG)

<a name="item2"></a>
## What is open-source?

"Open source" refers to a type of software whose source code is available to the public and is accessible and modifiable by anyone. This approach contrasts with proprietary software, where the source code is closed and not available to users.

- Access to Source Code
- Freedom of Modification
- Free Distribution
- Open License
- Collaborative Community

<a name="item3"></a>
## What are distros?

"Distros" is a commonly used abbreviation for "distributions" in the context of Linux-based operating systems. A Linux distribution, or distro, is a specific version of the Linux operating system that includes the Linux kernel, system software, package management tools, and often a desktop environment.

<a name="item4"></a>
## Linux System Structure

The structure of Linux is organized in layers, and its basic architecture can be described as follows:

- `Kernel`: The Linux kernel is the heart of the operating system. It manages hardware resources, such as processors, memory, input/output devices, and provides basic services for the rest of the system to function.
- `User Space`: The upper layer of the operating system is the user space, which includes all programs and applications that users interact with directly. This ranges from command-line utilities to complete desktop environments.
- `Shell`: The shell is the command-line interface that allows users to interact with the system. Users can execute commands directly or write scripts to perform automated tasks.
- `File System`: Linux uses a hierarchical file system that organizes files and directories in a tree structure. The main file system starts from the root directory ("/") and extends from there.
- `Package Manager`: Linux systems use package managers to manage the installation, updating, and removal of software. Common examples include apt (on Debian-based distributions, like Ubuntu) or yum (on Red Hat-based distributions, like Fedora).
- `System Libraries`: Linux uses a variety of shared libraries that provide essential functions and services for applications and the system in general.
- `Device Drivers`: Linux includes device drivers to support a wide range of hardware. These drivers allow the kernel to interact with specific hardware components.
- `Network and Protocols`: Linux includes support for networks and communication protocols. This includes the implementation of TCP/IP, network services, and network device drivers.
- `Processes and Running Programs`: Linux is a multiprocess operating system, which means it can run multiple processes simultaneously. Running processes include system services, user applications, and background tasks.
- `Graphical Environment (Optional)`: Although Linux can function in text mode, many distributions include desktop environments like GNOME, KDE, or XFCE to provide graphical user interfaces.

<a name="item5"></a>
## File Structure

The file structure in Linux-based operating systems follows an organized and coherent hierarchy. The file system has a tree structure with a root directory ("/") as the starting point. Here's an overview of some key directories in the Linux file structure:

![Diagram](https://github.com/Andherson333333/Linux/blob/main/estructura%20linux/imanges/linux-2.PNG)

- `/ (Root):` It's the main directory from which all other directories originate.
- `/bin (Binaries):` Contains essential binary files (executables) that are necessary for system operation, such as system commands and utilities.
- `/boot (Boot):` Contains files necessary for system boot, including the system kernel and other configuration files.
- `/dev (Devices):` Contains device files that represent interfaces to hardware devices and other system resources.
- `/etc (Configuration):` Stores system and application configuration files.
- `/home (Homes):` Is the main directory for personal user directories. Each user has their own subdirectory within /home.
- `/lib (Libraries):` Contains essential shared libraries used by programs in /bin and /sbin.
- `/media:` Used to mount removable devices such as USB drives and CD/DVDs.
- `/mnt (Mount):` Is a temporary mount point for additional file systems.
- `/opt (Optional):` Contains additional software packages installed by the user.
- `/proc (Process):` Provides information about running processes and real-time system status.
- `/root:` Is the root user (superuser) directory.
- `/run:` Contains runtime data, such as PID files and sockets, specific to the current system boot.
- `/sbin (Superuser binaries):` Stores essential system binaries, used by the superuser (root).
- `/srv (Services):` Contains data for services provided by the system.
- `/sys (System):` Provides an interface to interact with the kernel and configure system parameters at runtime.
- `/tmp (Temporary):` Stores temporary files used by programs and users.
- `/usr (Users):` Contains subdirectories with data and programs used by regular users.
- `/var (Variables):` Contains variable data, such as log files, mail files, and other files that can dynamically change in size during system use.
