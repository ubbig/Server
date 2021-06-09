docker pull postgres:13

sudo docker run --restart unless-stopped --name pgsql-master -d \
       	-p 5452:5452 -p 5552:22 \
       	-e POSTGRES_PASSWORD=selab1234 \
	-e TZ=Asiz/Seoul \
	-v /docker/pgsql-master:/var/lib/postgresql/data \
       	postgres:13

sleep 1

sudo cp -r config/master-config/* /docker/pgsql-master/

