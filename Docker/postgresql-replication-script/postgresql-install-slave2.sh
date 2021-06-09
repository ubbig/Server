docker pull postgres:13

sudo mkdir /docker
sudo docker run --restart unless-stopped --name pgsql-slave2 -d \
       	-p 5456:5456 -p 5563:22 \
       	-e POSTGRES_PASSWORD=selab1234 \
	-e TZ=Asia/Seoul \
	-v /docker/pgsql-slave2:/var/lib/postgresql/data \
       	postgres:13

sleep 1

sudo cp config/slave-config/* /docker/pgsql-slave2/

