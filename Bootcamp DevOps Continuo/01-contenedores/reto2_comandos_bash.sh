#!/bin/bash

net_name="challenge-net"
mongo_container=mongo-challenge
mongov_data=mongo-data
mongov_cnf=mongo-conf
backend_image=node-app-backend:v1.2
backend_container="node-challenge-backend"


# Repetir la estructura del reto 1
################################################################

if [ -z "$(docker network ls | grep $net_name)" ]; then
    docker network create $net_name
else
    echo "usando red existente"
fi

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

if ! docker ps -a --format '{{.Names}}' | grep -wq $mongo_container ; then
    docker run -d \
    --name $mongo_container \
    --mount type=volume,source=$mongov_data,target=/data/db \
    --mount type=volume,source=$mongov_cnf,target=/data/configdb \
    --memory="4g" --cpus="4" \
    --network challenge-net \
    mongo:8.2.1
else
    echo "usando container existente"
    docker start $mongo_container
fi
################################################################


# docker build de lo que se encuentra en ./docker-image-build/backend-build/Dockerfile

cd ./docker-image-build/backend-build

if ! docker images --format "{{.Repository}}:{{.Tag}}" | grep $backend_image ; then

    docker build . -f Dockerfile -t $backend_image
else
    echo imagen ya existente
fi


# ejecutar la imagen en la red del reto 1

if ! docker ps -a --format '{{.Names}}' | grep -wq $backend_container ; then
    docker run -d \
    --name $backend_container \
    --mount type=bind,source=.env,target=/usr/src/nodeapp/.env \
    --memory="4g" --cpus="4" \
    --network $net_name \
    -p 5000:5000 \
    $backend_image
else

    echo "usando container existente"
    docker start $backend_container
fi


# verificando que se da la conexión a MongoDB y haceindo el CRUD testing

sleep 3
host="http://localhost:5000"

if curl --fail $host/api/classes 2>/dev/null; then
    printf "\n***Get exitoso***\n"
else
    printf "\n***Fallo en el get***\n"
fi


docker stop $mongo_container
docker rm $mongo_container
docker stop $backend_container
docker rm $backend_container