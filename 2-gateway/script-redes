#!/bin/bash

# Obtener la lista de interfaces
interfaces=$(ip addr | awk -F ": " '/^[0-9]+: [a-zA-Z0-9]+:/ {print $2}')

# Mostrar la lista de interfaces disponibles
echo "Interfaces disponibles:"
echo "$interfaces"

# Solicitar al usuario que elija una interfaz
read -p "Seleccione una interfaz de la lista anterior: " seleccion

# Verificar si la selección es válida
if [[ $interfaces =~ (^|[[:space:]])$seleccion($|[[:space:]]) ]]; then
    echo "Has seleccionado la interfaz: $seleccion"
else
    echo "La selección no es válida."
    exit 1
fi

# Solicitar la dirección IP al usuario
read -p "Ingrese la dirección IP: " direccion_ip

# Verificar si la dirección IP es válida (puedes agregar validación adicional si es necesario)
if [[ ! $direccion_ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "La dirección IP ingresada no es válida."
    exit 1
fi

# Solicitar la máscara de red al usuario
read -p "Ingrese la máscara de red (ejemplo: 255.255.255.0): " netmask

# Validar la máscara de red
if [[ ! $netmask =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "La máscara de red ingresada no es válida."
    exit 1
fi

# Dividir la máscara en sus octetos
IFS='.' read -r -a octetos <<< "$netmask"

# Inicializar el valor CIDR
cidr=0

# Calcular el valor CIDR
for octeto in "${octetos[@]}"; do
    while [[ $octeto -gt 0 ]]; do
        cidr=$((cidr + octeto % 2))
        octeto=$((octeto / 2))
    done
done

# Solicitar la red al usuario
read -p "Ingrese la red (ejemplo: 10.2.32.0): " network

# Validar la red
if [[ ! $network =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "La red ingresada no es válida."
    exit 1
fi

# Solicitar la puerta de enlace al usuario
read -p "Ingrese la puerta de enlace (ejemplo: 10.2.32.1): " gateway

# Validar la puerta de enlace
if [[ ! $gateway =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "La puerta de enlace ingresada no es válida."
    exit 1
fi

# Crear el archivo rt_tables
cat <<EOF > rt_tables
10      $seleccion
EOF

# Crear el archivo interfaces
cat <<EOF > interfaces


# Interfaz principal
auto $seleccion
iface $seleccion inet static
    address $direccion_ip
    netmask $netmask
#    gateway $gateway

EOF

# Crear el archivo boot.sh con la dirección IP, la máscara de red, la red, la puerta de enlace, el nombre de la tabla y la interfaz
cat <<EOF > boot.sh
#!/bin/bash

# Regla de Entrada
ip route add $network/$cidr dev $seleccion src $direccion_ip table $seleccion
ip route add default via $gateway dev $seleccion table $seleccion

# Regla de Salida
ip rule add from $direccion_ip/32 table $seleccion
ip rule add to $direccion_ip/32 table $seleccion

EOF

# Dar permisos de ejecución a los archivos boot.sh, rt_tables e interfaces
chmod +x boot.sh
chmod +x rt_tables
chmod +x interfaces

echo "Se ha generado el archivo boot.sh"
echo "Se ha generado el archivo rt_tables."
echo "Se ha generado el archivo interfaces."

cat rt_tables >> /etc/iproute2/rt_tables
cat interfaces >> /etc/network/interfaces

# Mover el archivo boot.sh a /usr/local/bin/
#mv boot.sh /usr/local/bin/

#ejecutar boot
cd /usr/local/bin/ && ./boot.sh

/etc/init.d/networking restart

# Agregar la tarea al cron
(crontab -l 2>/dev/null; echo "@reboot cd /usr/local/bin/ && sleep 2s && ./boot.sh") | crontab -

ping_gateway=$(ip route | grep default | awk '{print $3}')

# Crear el archivo ping al gw
cat <<EOF > pingw.sh
#!/bin/bash

ping -c 8 $ping_gateway
ping -c 8 $gateway

EOF

# Mover ,dar permisos y ejecutar pingsw.sh
#mv pingw.sh /usr/local/bin/
chmod 750 /usr/local/bin/pingw.sh
cd /usr/local/bin/ && ./pingw.sh

# Agregar la tarea al cron
(crontab -l 2>/dev/null; echo "*/5 * * * * cd /usr/local/bin/ && ./pingw.sh") | crontab -
