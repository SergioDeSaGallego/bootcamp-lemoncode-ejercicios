#!/bin/bash

# ✅ Crear una red Docker para la comunicación

net_name=challenge-net
container_name=mongo-challenge
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

if ! docker ps -a --format '{{.Names}}' | grep -wq $container_name ; then
    docker run -d \
    --name $container_name \
    --mount type=volume,source=$mongov_data,target=/data/db \
    --mount type=volume,source=$mongov_cnf,target=/data/configdb \
    --memory="4g" --cpus="4" \
    --network challenge-net \
    -p 27017:27017 \
    mongo:8.2.1

else

    echo "usando container existente"
    docker start $container_name
fi

# ✅ Ejecutar el backend localmente conectándose a tu nuevo MongoDB

cd ./node-stack-local/backend/
npm install >/dev/null
npm start &
cd ../../

sleep 5

# ✅ Verificar que el CRUD funciona correctamente usando la extensión REST Client y el archivo backend/client.http del stack que hayas elegido

host="http://localhost:5000"
calls_POST=$(cat << EOF
{"name": "Contenedores I","instructor": "Gisela Torres","startDate": "2025-10-17T18:00:00Z","endDate": "2025-10-17T20:00:00Z","duration": 2,"level": "Beginner"}
{"name": "Contenedores II","instructor": "Gisela Torres","startDate": "2025-10-24T18:00:00Z","endDate": "2025-10-24T20:00:00Z","duration": 2,"level": "Beginner"}
{"name": "Contenedores III","instructor": "Gisela Torres","startDate": "2025-10-31T18:00:00Z","endDate": "2025-10-31T20:00:00Z","duration": 2,"level": "Beginner"}
{"name": "Contenedores IV","instructor": "Gisela Torres","startDate": "2025-11-07T18:00:00Z","endDate": "2025-11-07T20:00:00Z","duration": 2,"level": "Beginner"}
{"name": "Contenedores V","instructor": "Gisela Torres","startDate": "2025-11-14T18:00:00Z","endDate": "2025-11-14T20:00:00Z","duration": 2,"level": "Beginner"}
{"name": "Contenedores VI","instructor": "Gisela Torres","startDate": "2025-11-21T18:00:00Z","endDate": "2025-11-21T20:00:00Z","duration": 2,"level": "Beginner"}
{"name": "Azure Web Services I","instructor": "Gisela Torres","startDate": "2026-02-20T18:00:00Z","endDate": "2026-02-20T20:00:00Z","duration": 2,"level": "Beginner"}
{"name": "Azure Web Services II","instructor": "Gisela Torres","startDate": "2026-02-27T18:00:00Z","endDate": "2026-02-27T20:00:00Z","duration": 2,"level": "Beginner"}
{"name": "Kubernetes AKS","instructor": "Gisela Torres","startDate": "2026-03-13T18:00:00Z","endDate": "2026-03-13T20:00:00Z","duration": 2,"level": "Beginner"}
{"name": "SESIÓN IA I","instructor": "Gisela Torres","startDate": "2026-04-17T18:00:00Z","endDate": "2026-04-17T20:00:00Z","duration": 2,"level": "Beginner"}
{"name": "SESIÓN IA II","instructor": "Gisela Torres","startDate": "2026-04-24T18:00:00Z","endDate": "2026-04-24T20:00:00Z","duration": 2,"level": "Beginner"}
{"name": "SESIÓN IA III","instructor": "Gisela Torres","startDate": "2026-05-01T18:00:00Z","endDate": "2026-05-01T20:00:00Z","duration": 2,"level": "Beginner"}
EOF
)
call_PUT=$(cat << EOF
{"name": "Updated Class Name",
  "instructor": "New Instructor",
  "startDate": "2025-10-17T18:00:00Z",
  "endDate": "2025-10-17T20:00:00Z",
  "duration": 2,
  "level": "Intermediate"}
EOF
)



if curl $host/api/classes 2>/dev/null; then

    echo "Get exitoso, lanzando las API call"

    while IFS= read -r line
    do
        curl -X POST -H "Content-Type: application/json" -d "$line" $host/api/classes
    done < <(printf '%s\n' "$calls_POST")

    classId=$(curl -s $host/api/classes | jq -r '.[0]._id')
    curl $host/api/classes/$classId
    curl -X PUT -d "$call_PUT" $host/api/classes/$classId
    curl -X DELETE $host/api/classes/$classId
    curl  -X GET $host/api/classes
fi 

pkill -f "node app.js"
# kill $(ps aux | grep -v grep | grep "node app.js" | tr -s ' ' | cut -d ' ' -f 2)

docker stop $container_name