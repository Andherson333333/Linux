#!/bin/bash

# Ruta al archivo vars/main.yml
vars_file="lvmcreate/vars/main.yml"

# Mostrar valores actuales
echo "Valores actuales:"
cat "$vars_file"

# Pedir nuevos valores
read -p "Nuevo valor para pvs: " new_pvs
read -p "Nuevo valor para vg: " new_vg
read -p "Nuevo valor para lv: " new_lv
read -p "Nuevo valor para size: " new_size

# Modificar el archivo vars/main.yml con los nuevos valores
sed -i "s/vg:.*/vg: $new_vg/" "$vars_file"
sed -i "s|pvs:.*|pvs: $new_pvs|" "$vars_file"
sed -i "s/lv:.*/lv: $new_lv/" "$vars_file"
sed -i "s/size:.*/size: $new_size/" "$vars_file"

# Mostrar valores actualizados
echo -e "\nValores actualizados:"
cat "$vars_file"
