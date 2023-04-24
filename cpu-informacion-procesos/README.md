## Índice de contenidos
* [Antes de los comandos](#item1)
* [Comandos de caracteristicas CPU](#item2)
* [Comandos uso cpu y procesos](#item3)
* [Ahora que ¿pasa en el servidor destino?](#item4)


<a name="item1"></a>
## Antes de los comandos
Antes de lanzar los comando de cpu y procesos es recomendable verificar 2 cosas :

1) El tipo del sistema operativo que estamso trabajando
```
lsb_release -a
```

![Diagrama](https://github.com/Andherson333333/Linux/blob/main/cpu-informacion-procesos/imagenes/cpu-1.JPG)

![Diagrama](https://github.com/Andherson333333/Linux/blob/main/cpu-informacion-procesos/imagenes/cpu-2.JPG)


hay veces que el sistema operativo no trae el comando lsb_release -a , tambien puedes usar este

```
uname -a
```

![Diagrama](https://github.com/Andherson333333/Linux/blob/main/cpu-informacion-procesos/imagenes/cpu-3.2.JPG)

es un poco legible esta salidad compara al lsb pero con esta imagen puedes darte una idea como se usa (la opcion -a muetra todo)

![Diagrama](https://github.com/Andherson333333/Linux/blob/main/cpu-informacion-procesos/imagenes/cpu-4.JPG)


2) Si hay otros personas dentro del servidor 

```
w
```
![Diagrama](https://github.com/Andherson333333/Linux/blob/main/cpu-informacion-procesos/imagenes/cpu5.JPG)

<a name="item2"></a>
## Comandos de caracteristicas CPU
Estos comandos son solo 3 comandos pero , lo que tome en cuenta es que van a funcionar en casi todos los sistemas operativos incluso recien instalados , sin aceso a internet para instalar alguna herramienta


1 
Con este comando se tiene una amplia informacion del cpu y muchas caracteristicas
```
lscpu
```
![Diagrama](https://github.com/Andherson333333/Linux/blob/main/cpu-informacion-procesos/imagenes/cpu5.3.JPG)

La caracteristicas mas importates de este comando son las siguientes:

Architecture

CPU op-mode(s)

Thread(s) per core

Core(s) per socket

Model name

CPU MHz

Para que el comando no te muestra tanta informacion puedes usar este
```
lscpu | grep -E 'Architecture|CPU op-mode|Thread\(s\) per core|Core\(s\) per socket|Model name|CPU MHz'
```
![Diagrama](https://github.com/Andherson333333/Linux/blob/main/cpu-informacion-procesos/imagenes/cpu5.1.JPG)


2 El segundo comando tambien mueestra bastante caracteristicas pero, es un poco mas corto

```
cat /proc/cpuinfo
```

![Diagrama](https://github.com/Andherson333333/Linux/blob/main/cpu-informacion-procesos/imagenes/cpu-6.JPG)

de igual forma si se quiere filtrar por opciones puedes usar el siguiente filtro

```
cat /proc/cpuinfo | grep -E '|opcion1|opcion2|opcion3|opcion4|opcion5'
```

3 El tercer y ultimo comando muestra la misma informacion relevante pero con los nombres un poco diferentes

```
dmidecode --type processor
```

![Diagrama](https://github.com/Andherson333333/Linux/blob/main/cpu-informacion-procesos/imagenes/cpu-7.JPG)

<a name="item3"></a>
## Comandos uso cpu y procesos

