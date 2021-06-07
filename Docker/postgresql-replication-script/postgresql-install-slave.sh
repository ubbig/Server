docker pull postgres:13

sudo mkdir /docker
sudo docker run --restart unless-stopped --name pgsql-slave -d \
       	-p 5453:5453 -p 5553:22 \
       	-e POSTGRES_PASSWORD=selab1234 \
	-e TZ=Asia/Seoul \
	-v /docker/pgsql-slave:/var/lib/postgresql/data \
       	postgres:13

sudo cp config/slave-config/* /docker/pgsql-slave/

