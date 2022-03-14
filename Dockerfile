FROM node:alpine3.14
COPY package*.json ./
RUN npm install -g npm@8 && npm install express --save
COPY . .
EXPOSE 3000
CMD ["node","server.js"]
