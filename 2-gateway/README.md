
# Configuración de Red en Linux

## Descripción

Este script interactivo de Bash simplifica la configuración de la red en sistemas Linux, guiando al usuario a través de la configuración de la interfaz de red, dirección IP, máscara de red, puerta de enlace y la creación de archivos de configuración.

**Contenido**
Uso del Script
Ejecución del Script
Ejecuta el script en tu terminal:

bash
Copy code
bash nombre_del_script.sh
Selección de Interfaz
El script mostrará una lista de interfaces disponibles. Selecciona una interfaz de la lista proporcionada.

**Configuración de Dirección IP**
-Ingresa la dirección IP deseada cuando se solicite.

**Configuración de Máscara de Red**
-Ingresa la máscara de red. Asegúrate de seguir el formato adecuado (ejemplo: 255.255.255.0).

**Configuración de Red y Puerta de Enlace**
-Ingresa la red y la puerta de enlace. Se verificará que las entradas sean válidas.

**Generación de Archivos de Configuración**
-Se creará el archivo rt_tables para asignar una tabla de enrutamiento a la interfaz seleccionada.
-Se creará el archivo interfaces con la configuración de red para la interfaz seleccionada.
-Se creará el archivo boot.sh que establece reglas de enrutamiento y reglas de salida.
-Permisos y Ejecución de Archivos
-Se darán permisos de ejecución a los archivos generados y se ejecutará boot.sh para aplicar la configuración de red.

**Configuración Automática al Reiniciar**
-Se agregarán líneas al archivo /etc/iproute2/rt_tables.
-Se agregarán líneas al archivo /etc/network/interfaces.
-Se configurará el script boot.sh para ejecutarse en cada reinicio del sistema.
-Ping al Gateway
-Se creará el archivo pingw.sh que realiza pings al gateway y la puerta de enlace. Se ejecutará pingw.sh y se programará en cron para ejecutarse cada 5 minutos.

**Notas Adicionales**
-Consideraciones de Seguridad:
-El script asume que se ejecutará con privilegios de administrador (root).
-Asegúrate de revisar y ajustar la configuración según tus necesidades específicas.
-Información Adicional:
-La configuración se basa en las entradas proporcionadas por el usuario durante la ejecución del script.
-Se realizan verificaciones básicas de validez en las entradas proporcionadas.
-Registro de Actividad:
-Los archivos rt_tables, interfaces, y boot.sh se generan y registran la configuración aplicada.
-Este script facilita la configuración y automatización de la red en entornos Linux. Asegúrate de revisar y personalizar la configuración según tus --necesidades específicas antes de ejecutarlo.
