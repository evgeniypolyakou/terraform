#!/bin/bash
sudo apt-get update
sudo apt install docker.io -y
sudo usermod -aG docker $USER
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
sudo chmod 666 /var/run/docker.sock
sudo curl -L https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
cat > docker-compose.yml <<EOF
version: '3.8'

services:
  nodejs:
    image: iowa666/nodejs_app
    container_name: nodejs
    ports:
     - "3000:3000"
  nginx:
    restart: always
    image: iowa666/nginx
    container_name: nginx
    ports:
     - "80:80"
EOF
docker-compose up -d