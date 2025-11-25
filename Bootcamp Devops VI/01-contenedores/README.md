# Ejercicios



## Reto 1. Crear una red Docker para la comunicación
### > Comandos utilizados para crear la red Docker
```bash
docker network create challenge-net
```


## Reto 2. Ejecutar MongoDB en un contenedor con persistencia de datos
### > Comando para ejecutar el contenedor de MongoDB
```bash
docker volume create mongo-data
docker volume create mongo-conf

docker run -d \
    --name mongo-challenge \
    --mount type=volume,source=mongo-data,target=/data/db \
    --mount type=volume,source=mongo-conf,target=/data/configdb \
    --memory="4g" --cpus="4" \
    --network challenge-net \
    -p 27017:27017 \
    mongo:8.2.1
```
## Reto 3. Ejecutar el backend localmente conectándose a tu nuevo MongoDB
### > Configuración de conexión del backend a MongoDB
```bash

```
## Reto 4. Verificar que el CRUD funciona correctamente usando la extensión REST Client y el archivo backend/client.http del stack que hayas elegido
### > Prueba REST Client mostrando peticiones exitosas (backend/client.http)
```bash

```