#docker pull postgres:13

sudo mkdir /docker
sudo docker run --restart unless-stopped --name pgsql-slave -d \
	--network postgres-net \
       	-p 5434:5434 -p 5024:22 \
       	-e POSTGRES_PASSWORD=etri1234! \
	-e TZ=Asia/Seoul \
	-v /docker/pgsql-slave:/var/lib/postgresql/data \
       	postgres-selab

sleep 5

sudo cp config/slave-config/* /docker/pgsql-slave/
ssh-keygen -f ~/.ssh/id_rsa -N etri1234!
echo service ssh start >> /root/.bashrc
sudo docker restart pgsql-slave
