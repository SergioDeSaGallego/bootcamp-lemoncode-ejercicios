# Ejercicios

## Ejercicio 1. Monolito en memoria

### Paso 1 Crear un deployment para TODO-app

#### 1.0 Preparación, probaré la app en local y crearé una imagen de TODO

```bash
# Instalación de las dependencias

cd 00-monolith-in-mem/todo-app/frontend
npm install

cd ..
npm install

cd /frontend
npm run start:dev:server
```

##### > logs de la app en consola

![logs de la app en consola](/Bootcamp%20DevOps%20Continuo/02-orquestacion/00-monolith-in-mem/imagenes/applog_local.png)

##### > aplicacion todo corriendo en el buscador

![aplicacion todo corriendo en el buscador](/Bootcamp%20DevOps%20Continuo/02-orquestacion/00-monolith-in-mem/imagenes/app_browser.png)


```bash
# Creando la imagen a partir del Dockerfile proporcionado
docker build -t sdesa/lc-todo-00monolith .

#he dejado el puerto tal como estaba, decidí usar production en la variable de entorno
docker run -d -p 3001:3001 \
> -e NODE_ENV=production \
> -e PORT=3001 \
> sdesa/lc-todo-00monolith
```

#### 1.1 Creando y lanzando la imagen
![dockerbuildydockerrun](/Bootcamp%20DevOps%20Continuo/02-orquestacion/00-monolith-in-mem/imagenes/dockerbuilddockerrunoutput.png)

##### > La imagen funciona en browser
![todoappcondockerbrowser](/Bootcamp%20DevOps%20Continuo/02-orquestacion/00-monolith-in-mem/imagenes/todoappdesdedocker_browser.png)



#### 1.1 Crendo el deployment
  ##### Archivo [deployment.yaml](/Bootcamp%20DevOps%20Continuo/02-orquestacion/00-monolith-in-mem/kubernetes/deployment.yaml)


> Nota: Intenté lanzar el deployment tal cual pero me tiró errimagepull, con un describe descubrí que está intentando pillar la imagen de un repositoiro no existem, y no localmente.

![errimagepull](/Bootcamp%20DevOps%20Continuo/02-orquestacion/00-monolith-in-mem/imagenes/errimagepull.png)
![errimagepullreason](/Bootcamp%20DevOps%20Continuo/02-orquestacion/00-monolith-in-mem/imagenes/errimagepullreason.png)


> Para que use la imagen sdesa/lc-todo-00monolith que tengo en local, necesito cargarla en minikube, además de añadir imagePullPolicy: Never en el deployment.yaml

```bash
minikube image load sdesa/lc-todo-00monolith 
```

![podok](/Bootcamp%20DevOps%20Continuo/02-orquestacion/00-monolith-in-mem/imagenes/podrunning.png)


### Paso 2. Accedee a todo-app desde fuera del clúster

#### 2.1 Creamos el tunel en minikube para que mapee una ip al servicio que expondremos

![tunelcreado](/Bootcamp%20DevOps%20Continuo/02-orquestacion/00-monolith-in-mem/imagenes/minikubetunnel.png)

#### 2.2 Lanzamos de nuevo el deployment en otra terminal y lo exponemos

```bash
kubectl apply -f deployment.yaml
kubectl expose deployment todo-app00 --type=LoadBalancer --port=3000 --target-port=3000
```

> La parte de target port en principio no hacía falta, si no se pone --target-port usará el puerto en --port, lo dejo así por si quisiera usar un puerto distinto para el servicio expuesto y conservar la configuración del deployment.



![lanzandoservicio](/Bootcamp%20DevOps%20Continuo/02-orquestacion/00-monolith-in-mem/imagenes/lanzandoservicio.png)
![serviciofuncional](/Bootcamp%20DevOps%20Continuo/02-orquestacion/00-monolith-in-mem/imagenes/serviciofuncional.png)

