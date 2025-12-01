# Imagen en uso
FROM node:22-alpine3.21

# Etiquetas
LABEL maintainer="sdesagallego@gmail.com"
LABEL project="lemoncode-challenge-containers"
LABEL version=1

# App WORKDIR
WORKDIR /usr/src/node-app

# Copiar archivos de dependencias
COPY ["node-stack/backend/package.json", "node-stack/backend/package-lock.json"] ./

# Instalar dependencias
RUN npm ci

# Copiar aplicación backend
COPY node-stack/backend/app.js ./
RUN npm start

# Expuesto el puerto del backend de la aplicación de calendario
EXPOSE 5000


