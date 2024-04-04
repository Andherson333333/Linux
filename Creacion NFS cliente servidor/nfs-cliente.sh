#!/bin/bash

# Solicitar la ruta de montaje local
read -p "Ingrese la ruta de montaje local (por ejemplo, /storage): " ruta_montaje

# Solicitar la dirección IP del servidor NFS
read -p "Ingrese la dirección IP del servidor NFS: " ip_servidor

# Solicitar la ruta del directorio compartido en el servidor NFS
read -p "Ingrese la ruta del directorio compartido en el servidor NFS: " ruta_compartida

# Actualizar los paquetes e instalar el cliente NFS
sudo apt update
sudo apt install nfs-common

# Crear la carpeta de montaje local
mkdir -p "$ruta_montaje"

# Montar el sistema de archivos NFS
sudo mount -t nfs "$ip_servidor:$ruta_compartida" "$ruta_montaje"

# Agregar la entrada al archivo /etc/fstab
echo "$ip_servidor:$ruta_compartida $ruta_montaje nfs defaults 0 0" | sudo tee -a /etc/fstab

