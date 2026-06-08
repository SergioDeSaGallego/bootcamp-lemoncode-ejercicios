#!/bin/bash

# 0 Probar app en local y construir la imagen de la aplicación

cd 00-monolith-in-mem/todo-app/frontend/
npm install

npm audit
npm audit fix

cd ../
npm install

npm audit
npm audit fix

cd frontend/
# npm run start:dev:server


cd ../
docker build -t sdesa/lc-todo-00monolith .
# docker run -d -p 3001:3001 \
# > -e NODE_ENV=production \
# > -e PORT=3001 \
# > sdesa/lc-todo-00monolith


# # 1 Crear un Deployment para todo-app

minikube image load sdesa/lc-todo-00monolith
kubectl apply -f deployment.yaml


# # 2 Acceder al cluster desde fuera

minikube tunnel
kubectl apply -f service.yaml
