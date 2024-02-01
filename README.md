# docker-lamp-ubuntu

Example to run LAMP(Apache, MariaDB, PHP) stack on Ubuntu docker image.

## Prerequisites
[Install Docker](https://docs.docker.com/manuals/)

## Installation
1. Clone the repo
```
git clone https://github.com/ttiverson3/docker-lamp-ubuntu.git
cd docker-lamp-ubuntu
```
2. Build docker image
```
docker build -t lamp:u20 .
```
3. Run container
```
docker run -d -p 80:80 --name lamp lamp:u20
```
4. Point browser to: http://localhost and http://localhost/phpmyadmin