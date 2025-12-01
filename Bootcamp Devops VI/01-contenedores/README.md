# Ejercicios


## Reto 1

### 1. Crear una red Docker para la comunicación
#### Crear la red modo bridge
```bash
docker network create challenge-net
```


### 2. Ejecutar MongoDB en un contenedor con persistencia de datos
#### Creando los volúmenes
```bash
docker volume create mongo-data
docker volume create mongo-conf
```

#### Creando el contenedor
```bash
docker run -d \
    --name mongo-challenge \
    --mount type=volume,source=mongo-data,target=/data/db \
    --mount type=volume,source=mongo-conf,target=/data/configdb \
    --memory="4g" --cpus="4" \
    --network challenge-net \
    -p 27017:27017 \
    mongo:8.2.1
```
### 3. Ejecutar el backend localmente conectándose a tu nuevo MongoDB
#### Archivo .env
```bash
DATABASE_URL=mongodb://localhost:27017
DATABASE_NAME=LemoncodeCourseDb
HOST=localhost
PORT=5000
```

> Nota: Solo se mantiene así para la conexión con el backend en local, lo de node-stack estará diferentes según los siguientes retos.

### 4. Verificar que el CRUD funciona correctamente usando la extensión REST Client y el archivo backend/client.http del stack que hayas elegido
#### Con comandos de curl

```bash
host="http://localhost:5000"
POST=$(cat << EOF
{"name": "Contenedores I","instructor": "Gisela Torres","startDate": "2025-10-17T18:00:00Z","endDate": "2025-10-17T20:00:00Z","duration": 2,"level": "Beginner"}
EOF
)
curl -X POST -H "Content-Type: application/json" -d "$POST" $host/api/classes
```

![Imagen de respuesta con curl, reto1](imagenes/api_call_con_curl_reto1.jpg)

##### En [reto_1_comandos_bash.sh](./reto1_comandos_bash.sh) están todas las API call que nos disteis con [client.http](./node-stack/backend/client.http), las usé todas de golpe para probar la API y generar la semilla. No hace falta para el ejercicio esa parte, pero las dejé ahí. Dejo imagen de prueba también.

![Imagen de respuesta con curl automatizado, reto1](imagenes/todas_las_api_call_con_curl_reto1.jpg)

#### con la extensión REST Client de VS Code

![Imagen con REST Client de VS Code](imagenes/api_call_con_REST_Client.jpg)



## Reto 2

