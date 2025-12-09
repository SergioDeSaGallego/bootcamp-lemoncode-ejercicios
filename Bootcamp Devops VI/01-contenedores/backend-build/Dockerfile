# syntax=docker/dockerfile:1

ARG NODE_VERSION=22.21.1

FROM node:22-alpine3.21

ENV NODE_ENV=production

LABEL maintainer="sdesagallego@gmail.com"
LABEL project="lemoncode-challenge-containers"

WORKDIR /usr/src/nodeapp

RUN --mount=type=bind,source=package.json,target=package.json \
    --mount=type=bind,source=package-lock.json,target=package-lock.json \
    --mount=type=cache,target=/root/.npm \
    npm ci --omit=dev

COPY . .
RUN chown -R node /usr/src/nodeapp

USER node

EXPOSE 5000

CMD [ "npm", "start"]
