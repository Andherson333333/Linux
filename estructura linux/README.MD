## Índice de contenidos
* [Que es linux?](#item1)
* [Que es open-source?](#item2)
* [Que es una distros](#item3)
* [Estructrua sistema linux](#item4)
* [Estructura de archivos](#item5)


<a name="item1"></a>
## Que es linux?

Linux es un sistema operativo de tipo Unix que se caracteriza por ser de código abierto y gratuito. Su núcleo, o kernel, fue creado por Linus Torvalds y es mantenido por una amplia comunidad de desarrolladores. A diferencia de otros sistemas operativos, Linux permite a los usuarios acceder y modificar su código fuente, lo que fomenta la colaboración y adaptación a diversas necesidades.

Este sistema operativo se destaca por su estabilidad, seguridad y eficiencia en entornos de servidor, pero también es utilizado en sistemas embebidos, computadoras personales y otros dispositivos.

Como se sabe linux es un sistema monolitico que se basa en el kernel para controlar la mayor parte del sistema

![Diagrama](https://github.com/Andherson333333/Linux/blob/main/estructura%20linux/imanges/linux-1.PNG)

<a name="item2"></a>
## Que es open-source?

"Open source" (código abierto) se refiere a un tipo de software cuyo código fuente está disponible para el público y es accesible y modificable por cualquier persona. Este enfoque contrasta con el software propietario, donde el código fuente está cerrado y no está disponible para los usuarios.

- Acceso al Código Fuente
- Libertad de Modificación
- Distribución Libre
- Licencia Abierta
- Comunidad Colaborativa

<a name="item3"></a>
## Que es una distros

"Distros" es una abreviatura comúnmente utilizada para referirse a "distribuciones" en el contexto de sistemas operativos basados en Linux. Una distribución de Linux, o distro, es una versión específica del sistema operativo Linux que incluye el kernel de Linux, software de sistema, herramientas de gestión de paquetes, y a menudo un entorno de escritorio.

<a name="item4"></a>
## Estructrua sistema linux

La estructura de Linux se organiza en capas, y su arquitectura básica se puede describir de la siguiente manera:

- `Kernel` El núcleo o kernel de Linux es el corazón del sistema operativo. Se encarga de gestionar los recursos del hardware, como procesadores, memoria, dispositivos de entrada/salida, y proporciona los servicios básicos para que el resto del sistema funcione.
- `Espacio de Usuario` La capa superior del sistema operativo es el espacio de usuario, que incluye todos los programas y aplicaciones que los usuarios interactúan directamente. Esto abarca desde utilidades de línea de comandos hasta entornos de escritorio completos.
- `Shell` El shell es la interfaz de línea de comandos que permite a los usuarios interactuar con el sistema. Los usuarios pueden ejecutar comandos directamente o escribir scripts para realizar tareas automatizadas.
- `Sistema de Archivos` Linux utiliza un sistema de archivos jerárquico que organiza los archivos y directorios en una estructura de árbol. El sistema de archivos principal se inicia desde el directorio raíz ("/") y se extiende a partir de ahí.
- `Administrador de Paquetes` Los sistemas Linux utilizan administradores de paquetes para gestionar la instalación, actualización y eliminación de software. Ejemplos comunes incluyen apt (en distribuciones basadas en Debian, como Ubuntu) o yum (en distribuciones basadas en Red Hat, como Fedora).
- `Librerías del Sistema` Linux utiliza una variedad de bibliotecas compartidas (librerías) que proporcionan funciones y servicios esenciales para las aplicaciones y el sistema en general.
- `Controladores de Dispositivos` Linux incluye controladores de dispositivos para soportar una amplia gama de hardware. Estos controladores permiten que el kernel interactúe con componentes de hardware específicos.
- `Red y Protocolos` Linux incluye soporte para redes y protocolos de comunicación. Esto incluye la implementación de TCP/IP, servicios de red, y controladores de dispositivos de red.
- `Procesos y Programas en Ejecución` Linux es un sistema operativo multiproceso, lo que significa que puede ejecutar varios procesos simultáneamente. Los procesos en ejecución incluyen servicios del sistema, aplicaciones de usuario y tareas en segundo plano
- `Entorno Gráfico (Opcional)` Aunque Linux puede funcionar en modo texto, muchas distribuciones incluyen entornos de escritorio como GNOME, KDE, o XFCE para proporcionar interfaces gráficas de usuario.

<a name="item5"></a>
## Estructura de archivos

La estructura de archivos en sistemas operativos basados en Linux sigue una jerarquía organizada y coherente. El sistema de archivos tiene una estructura de árbol con un directorio raíz ("/") como punto de partida. Aquí hay una descripción general de algunos directorios clave en la estructura de archivos de Linux:

- `/ (Raíz):` Es el directorio principal desde el cual se originan todos los demás directorios.
- `/bin (Binarios):` Contiene archivos binarios esenciales (ejecutables) que son necesarios para el funcionamiento del sistema, como comandos del sistema y utilidades.
- `/boot (Arranque):` Contiene los archivos necesarios para el arranque del sistema, incluyendo el kernel del sistema y otros archivos de configuración.
- `/dev (Dispositivos):` Contiene archivos de dispositivos que representan interfaces a dispositivos de hardware y otros recursos del sistema.
- `/etc (Configuración):` Almacena archivos de configuración del sistema y de aplicaciones.
- `/home (Hogares):` Es el directorio principal para los directorios de usuarios personales. Cada usuario tiene su propio subdirectorio dentro de /home.
- `/lib (Bibliotecas):` Contiene bibliotecas compartidas esenciales utilizadas por programas en /bin y /sbin.
- `/media:` Se utiliza para montar dispositivos extraíbles como unidades USB y CD/DVD.
- `/mnt (Montaje):` Es un punto de montaje temporal para sistemas de archivos adicionales.
- `/opt (Opcionales):` Contiene paquetes de software adicionales instalados por el usuario.
`/proc (Proceso):` Proporciona información sobre procesos en ejecución y el estado del sistema en tiempo real.
- `/root:` Es el directorio del usuario root (superusuario).
- `/run:` Contiene datos de tiempo de ejecución, como archivos PID y sockets, específicos para el arranque actual del sistema.
- `/sbin (Superusuario binarios):` Almacena binarios esenciales para el sistema, utilizados por el superusuario (root).
- `/srv (Servicios):` Contiene datos para servicios proporcionados por el sistema.
`/sys (Sistema):` Proporciona una interfaz para interactuar con el kernel y configurar parámetros del sistema en tiempo de ejecución.
`/tmp (Temporal):` Almacena archivos temporales utilizados por programas y usuarios.
 `/usr (Usuarios):` Contiene subdirectorios con datos y programas utilizados por usuarios regulares.
- `/var (Variables):` Contiene datos variables, como archivos de registro, archivos de correo y otros archivos que pueden cambiar de tamaño dinámicamente durante el uso del sistema.

![Diagrama](https://github.com/Andherson333333/Linux/blob/main/estructura%20linux/imanges/linux-2.PNG)









