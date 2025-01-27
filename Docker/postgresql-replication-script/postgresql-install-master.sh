#docker pull postgres:13

sudo docker run --restart unless-stopped --name pgsql-master -d \
	--network postgres-net \
       	-p 5433:5432 -p 5023:22 \
	-e POSTGRES_USER=etri \
       	-e POSTGRES_PASSWORD=etri1234! \
	-e TZ=Asiz/Seoul \
	-v /docker/pgsql-master:/var/lib/postgresql/data \
       	postgres-selab

sleep 5

sudo cp -r config/master-config/* /docker/pgsql-master/
docker exec pgsql-master sh -c "ssh-keygen -t rsa -f ~/.ssh/id_rsa"

docker exec pgsql-master sh -c "echo service ssh start >> /root/.bashrc"

docker exec pgsql-master su - postgres -c "psql -U etri -d etri -p 5432 -c \"create user repl replication password 'etri1234!';\""

docker exec pgsql-master su - postgres -c "psql -U etri -d etri -p 5432 -c \"SELECT * FROM pg_create_physical_replication_slot('repl_slot_01');\""

sudo docker restart pgsql-master
