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
La ubicacion por defecto es el home del usuario , 

```
cd /home/usuario/.ssh
```


```
ssh-copy-id username@remote_host
```


