#!/bin/bash

# https://hub.docker.com/_/postgres
docker pull postgres:13.0

docker network create --driver=bridge postgres-net

docker run -i --rm postgres cat /usr/share/postgresql/postgresql.conf.sample > my-postgres.conf

sudo mkdir -p /docker_data/postgresql/config
sudo mv my-postgres.conf /docker_data/postgresql/config

docker run -d --restart unless-stopped --name postgresql -p 5432:5432 \
	-v /docker_data/postgresql/data:/var/lib/postgresql/data \
	-v /docker_data/postgresql/config:/etc/postgresql/config \
	-e POSTGRES_PASSWORD='selab' \
	--network postgres-net \
	postgres:13.0 -c 'config_file=/etc/postgresql/config/my-postgres.conf'

sudo firewall-cmd --permanent --zone=public --add-port=5432/tcp
sudo firewall-cmd --reload
