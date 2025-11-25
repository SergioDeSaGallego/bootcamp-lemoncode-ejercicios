#!/bin/bash

# ✅ Crear una red Docker para la comunicación

net_name=challenge-net
mongov_data=mongo-data
mongov_cnf=mongo-conf

if [ -z "$(docker network ls | grep $net_name)" ]; then
    docker network create $net_name
else
    echo "usando red existente"
fi

# ✅ Ejecutar MongoDB en un contenedor con persistencia de datos

if [ -z "$(docker volume ls | grep $mongov_data)" ]; then
    docker volume create $mongov_data
else
    echo "usando volumen existente"
fi

if [ -z "$(docker volume ls | grep $mongov_cnf)" ]; then
    docker volume create $mongov_cnf
else
    echo "usando volumen existente"
fi

# ✅ Ejecutar el backend localmente conectándose a tu nuevo MongoDB


docker run -d \
    --name mongo-challenge \
    --mount type=volume,source=$mongov_data,target=/data/db \
    --mount type=volume,source=$mongov_cnf,target=/data/configdb \
    --memory="4g" --cpus="4" \
    --network challenge-net \
    -p 27017:27017 \
    mongo:8.2.1

# cd ./node-stack/backend/
# npm install
# npm start

# ✅ Verificar que el CRUD funciona correctamente usando la extensión REST Client y el archivo backend/client.http del stack que hayas elegido



