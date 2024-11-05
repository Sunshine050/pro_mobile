FROM node:23-alpine

WORKDIR /usr/src/app

COPY package.json package-lock.json ./

RUN npm ci && npm cache clean --force
RUN apk add vim

COPY . .

EXPOSE 3000

CMD [ "npm", "run", "dev" ]