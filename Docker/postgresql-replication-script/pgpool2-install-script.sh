#!bin/bash

mkdir -p /docker/pgpool/

docker network create --driver=bridge postgres-net

docker load -i docker-images/pgpool-image.tar

docker run -d --restart unless-stopped --name pgpool-selab \
 	--network postgres-net \
       	-e POSTGRES_PASSWORD=etri1234! \
       	-v /docker/pgpool/postgresql:/var/lib/postgresql/data \
       	-v /docker/pgpool/pgpool:/etc/pgpool2 \
      	-p 9999:9999 \
	-p 9998:9998 \
	-p 5432:5432 \
	-p 5022:22 \
       	-e TZ=Asia/Seoul pgpool-selab

sleep 5

sudo cp config/h-config/* /docker/pgpool/postgresql/
sudo cp config/pgpool-config/* /docker/pgpool/pgpool/
docker exec pgpool-selab sh -c "ssh-keygen -t rsa -f ~/.ssh/id_rsa"
docker exec pgpool-selab sh -c "echo service ssh start >> /root/.bashrc"
docker exec pgpool-selab sh -c "echo pgpool >>/root/.bashrc"
docker restart pgpool-selab
