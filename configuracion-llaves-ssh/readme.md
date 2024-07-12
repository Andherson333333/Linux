# SSH Key Configuration Guide

This guide explains how to generate and configure SSH keys for secure remote access.

## Table of Contents
* [Generating the RSA Key](#generating-the-rsa-key)
* [Location of Generated Keys](#location-of-generated-keys)
* [Final Step](#final-step)
* [What Happens on the Destination Server?](#what-happens-on-the-destination-server)

## Generating the RSA Key

To generate an SSH RSA key, use the following command:

```bash
ssh-keygen
```

After running the command, you'll see this screen:

![SSH Keygen Screen](https://github.com/Andherson333333/Linux/blob/main/configuracion-llaves-ssh/imagenes/imagen-1.1.JPG)

Pressing enter for all options will use the default configuration. As you can see in the image, the key has RSA 3072 encryption with SHA256.

Note:
If you want to use a different encryption, you can do so with the `-t` option. Here are examples with different encryption types:

```bash
ssh-keygen -t rsa -b 4096
ssh-keygen -t dsa 
ssh-keygen -t ecdsa -b 521
ssh-keygen -t ed25519
```

## Location of Generated Keys

The default location is the user's home directory. When you run `ssh-keygen`, it creates a `.ssh` folder:

```bash
cd /home/username/
```

![SSH Folder](https://github.com/Andherson333333/Linux/blob/main/configuracion-llaves-ssh/imagenes/imagen-2.JPG)

Inside the `.ssh` folder, there are two files:

```bash
cd /home/username/.ssh
```

![SSH Key Files](https://github.com/Andherson333333/Linux/blob/main/configuracion-llaves-ssh/imagenes/imagen2.2.JPG)

- `id_rsa`: Private key
- `id_rsa.pub`: Public key

## Final Step

Copy the public key to the destination server. There are several ways to do this:

1) Use this command to automatically export and create a folder on the destination server with the public key:

```bash
ssh-copy-id username@remote_host
```

When you run this command, you'll see the following screen:

![SSH Copy ID](https://github.com/Andherson333333/Linux/blob/main/configuracion-llaves-ssh/imagenes/imagen3.JPG)

Now, to test if it works, log in with the normal SSH command as indicated in the output message:

![SSH Login](https://github.com/Andherson333333/Linux/blob/main/configuracion-llaves-ssh/imagenes/imagen3.3.JPG)

## What Happens on the Destination Server?

On the destination server, in the home directory of the accessed user (`/home/destination-server/.ssh`), a `.ssh` folder is created.

Inside this folder, an `authorized_keys` file is created:

![Authorized Keys File](https://github.com/Andherson333333/Linux/blob/main/configuracion-llaves-ssh/imagenes/imagen4.1.JPG)

This file contains the public key from the origin, i.e., `id_rsa.pub`.

When you `cat authorized_keys`:

![Authorized Keys Content](https://github.com/Andherson333333/Linux/blob/main/configuracion-llaves-ssh/imagenes/imagen4.2.JPG)

And when you `cat` the `id_rsa.pub` on the origin server:

![Public Key Content](https://github.com/Andherson333333/Linux/blob/main/configuracion-llaves-ssh/imagenes/imagen4.5.JPG)

As you can see, the content of both files is the same.

## Quick Reference

### Commands to generate and copy key to server
```bash
ssh-keygen
ssh-copy-id username@remote_host
```

### Types of keys
```bash
ssh-keygen -t rsa -b 4096
ssh-keygen -t dsa 
ssh-keygen -t ecdsa -b 521
ssh-keygen -t ed25519
```

### Location of keys
```
/home/username/.ssh
```


