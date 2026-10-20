# Ejercicios

## Ejercicio 0. Monolito en memoria.

### Paso 0. Lanzar app en local y crear imagen de app
```bash
cd 00-monolith-in-mem/todo-app/frontend/
npm install
```

![npm install con vulnerabilidades](/02-orquestación/imagenes/npminstall.png)
```bash
npm audit
npm audit fix
```
![audit fix](/02-orquestación/imagenes/auditfix.png)

```bash
cd ../
npm install
```
![npm install 2](/02-orquestación/imagenes/npminstall2.png)

```bash
npm audit
npm audit fix
```
![auditfix2](/02-orquestación/imagenes/auditfix2.png)


```bash
cd frontend/
npm run start:dev:server
```

![applog_local](/02-orquestación/imagenes/applog_local.png)
![apprunning_browser](/02-orquestación/imagenes/aprunning_browser.png)


```bash
docker build -t sdesa/lc-todo-00monolith .
docker run -d -p 3001:3001 \
> -e NODE_ENV=production \
> -e PORT=3001 \
> sdesa/lc-todo-00monolith
```
![dockerbuildandrun](/02-orquestación/imagenes/dockerbuildandrun.png)
![apprunningfromdocker](/02-orquestación/imagenes/appruningfromdocker.png)


### Paso 1. Crear un Deployment para todo-app

#### Archivo [deplouyment.yaml](/02-orquestación/00-monolith-in-mem/todo-app/kubernetes/deployment.yaml)

```bash
kubectl apply -f deployment.yaml
```

> Nota: quería usar la imagen que tenía en local, pero minikube intenta sacar la imagen de dockerhub en lugar de la que está guardada en local

![errimagepull](/02-orquestación/imagenes/rrimagepull.png)
![minikubintentandohacerpull](/02-orquestación/imagenes/minikubeintentandohacerpull.png)

> Lo arreglé añadiendo imagePullPolicy: Never al deployment y usando minikube image load para que la imagen se cargue en minikube

```bash
minikube image load sdesa/lc-todo-00monolith
```
![imagenenminikube](/02-orquestación/imagenes/imagenenminikube.png)

> Ya funcionando
![deploysrunning](/02-orquestación/imagenes/deploysrunning.png)


### Paso 2. Acceder a todo-app desde fuera del clúster

##### > Siguiendo la [guia](https://minikube.sigs.k8s.io/docs/handbook/accessing/#loadbalancer-access) sobre minikube proporcionada en el ejercicio

```bash
minikube tunnel
```
> Crea un external IP hacia el cluster


#### Archivo [service.yaml](/02-orquestación/00-monolith-in-mem/todo-app/kubernetes/service.yaml)
```bash
kubectl apply -f service.yaml
```

![getsvc](/02-orquestación/imagenes/getsvc.png)

![browsersvc](/02-orquestación/imagenes/browsersbv.png)


 
## Ejercicio 1. Monolito.





## Ejercicio 2. Aplicación Distribuida

