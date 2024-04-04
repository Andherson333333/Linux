#!/bin/bash

# Solicitar la ruta de la carpeta
read -p "Ingresa la ruta de la carpeta a crear: " carpeta

# Solicitar la dirección IP del cliente NFS
read -p "Ingresa la dirección IP del cliente NFS: " ip_cliente

# Actualizar los paquetes e instalar el servidor NFS
sudo apt update
sudo apt install -y nfs-kernel-server

# Crear la carpeta especificada por el usuario
mkdir -p "$carpeta"

# Asignar los permisos adecuados a la carpeta
chown -R nobody:nogroup "$carpeta"

# Agregar la entrada al archivo /etc/exports
echo "$carpeta $ip_cliente(rw,sync,no_subtree_check)" | sudo tee -a /etc/exports

# Reiniciar el servidor NFS para aplicar los cambios
sudo exportfs -ra
sudo systemctl restart nfs-kernel-server


