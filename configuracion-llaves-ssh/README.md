![Diagrama](https://github.com/Andherson333333/Linux/blob/main/configuracion-llaves-ssh/imagenes/ssh-llave-rsa.JPG)

## Generar la llave RSA
Para generar la llave ssh-rsa se realiza con el siguiente comando
```
ssh-keygen
```
Luego de lanzar el comando te saldra esta pantalla

![Diagrama](https://github.com/Andherson333333/Linux/blob/main/configuracion-llaves-ssh/imagenes/imagen-1.1.JPG)

Al dale enter en todas las opciones se realiza la configuracion, por defecto o estadar .Como se puede ver en la imagen la llave tiene un cifrado de RSA 3072 con SHA256

Nota:
Si desea colocar algun otro cifrado lo puede realiza con la opcion -t , como en este ejemplo con diferentes tipos cifrado

```
ssh-keygen -t rsa -b 4096
ssh-keygen -t dsa 
ssh-keygen -t ecdsa -b 521
ssh-keygen -t ed25519
```


## Ubicacion de la llaves generadas
La ubicacion por defecto es el home del usuario , al darle ssh-keyge se genera una carpeta .ssh 

```
cd /home/usuario/
```
![Diagrama](https://github.com/Andherson333333/Linux/blob/main/configuracion-llaves-ssh/imagenes/imagen-2.JPG)

al entrar en la carpeta .ssh hay 2 archivos
```
cd /home/usuario/.ssh
```
![Diagrama](https://github.com/Andherson333333/Linux/blob/main/configuracion-llaves-ssh/imagenes/imagen2.2.JPG)

id_rsa--->llave privada

id_rsa.pub--->llave publica


## Ultimo paso 
Copiar la llave publica al servidor destino ,para hacer esto hay varias formas:

1) lanzando este comando que exporta de forma automatica y crea una carpeta en el servidor destino con la llave publica
```
ssh-copy-id username@remote_host
```
al realizar este comando saldra la siguiente pantalla

![Diagrama](https://github.com/Andherson333333/Linux/blob/main/configuracion-llaves-ssh/imagenes/imagen3.JPG)

ahora para probar que funciona hacer login con el ssh normal como lo indica el mensaje de salidad

![Diagrama](https://github.com/Andherson333333/Linux/blob/main/configuracion-llaves-ssh/imagenes/imagen3.3.JPG)

## Ahora que ¿pasa en el servidor destino?

En el servidor destino en el home (/home/servidor-destino/.ssh) del usuario que se acedio se crea una carpeta .ssh .
Dentro de esa carpeta se crea un archivo authorized_keys

![Diagrama](https://github.com/Andherson333333/Linux/blob/main/configuracion-llaves-ssh/imagenes/imagen4.1.JPG)

Este archivo contiene la llave publica del origen es decir id_rsa.pub

![Diagrama](https://github.com/Andherson333333/Linux/blob/main/configuracion-llaves-ssh/imagenes/imagen4.1.JPG)

Al darle un cat authorized_keys

![Diagrama](https://github.com/Andherson333333/Linux/blob/main/configuracion-llaves-ssh/imagenes/imagen4.2.JPG)


y al darle un cat al servidor origuen id_rsa.pub

![Diagrama](https://github.com/Andherson333333/Linux/blob/main/configuracion-llaves-ssh/imagenes/imagen4.5.JPG)

Como puede notar es el mismo contenido del archivo




