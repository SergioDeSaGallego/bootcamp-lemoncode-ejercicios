# Ejercicios

## Ejercicio 1. Monolito en memoria

### Paso 1 Crear un deployment para TODO-app

#### Preparación, probaré la app en local y crearé una imagen de TODO

```bash
# Instalación de las dependencias

cd 00-monolith-in-mem/todo-app/frontend
npm install

cd ..
npm install

cd /frontend
npm run start:dev:server
```

#### logs de la app en consola

![logs de la app en consola](/Bootcamp%20DevOps%20Continuo/02-orquestacion/00-monolith-in-mem/imagenes/applog_local.png)

#### aplicacion todo corriendo en el buscador

![aplicacion todo corriendo en el buscador](/Bootcamp%20DevOps%20Continuo/02-orquestacion/00-monolith-in-mem/imagenes/app_browser.png)


```bash
# Creando la imagen a partir del Dockerfile proporcionado
docker build -t sdesa/lc-todo-00monolith .
docker run -d -p 3001:3001 \
> -e NODE_ENV=production \
> -e PORT=3001 \
> sdesa/lc-todo-00monolith
```

```bash
#he dejado el puerto tal como estaba, decidí usar production en la variable de entorno
docker run -d -p 3000:3000 \
  -e NODE_ENV=production \
  -e PORT=3000 \
  jaimesalas/lc-todo-monolith
```

#### Creando y lanzando la imagen
![dockerbuildydockerrun](/Bootcamp%20DevOps%20Continuo/02-orquestacion/00-monolith-in-mem/imagenes/dockerbuilddockerrunoutput.png)

#### La imagen funciona en browser
![todoappcondockerbrowser](/Bootcamp%20DevOps%20Continuo/02-orquestacion/00-monolith-in-mem/imagenes/todoappdesdedocker_browser.png)



### Paso 2. Accedee a todo-app desde fuera del clúster
