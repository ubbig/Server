#docker pull postgres:13

sudo docker run --restart unless-stopped --name pgsql-master -d \
	--network postgres-net \
       	-p 5433:5433 -p 5023:22 \
	-e POSTGRES_USER=etri \
       	-e POSTGRES_PASSWORD=etri1234! \
	-e TZ=Asiz/Seoul \
	-v /docker/pgsql-master:/var/lib/postgresql/data \
       	postgres-selab

sleep 5

sudo cp -r config/master-config/* /docker/pgsql-master/
ssh-keygen -f ~/.ssh/id_rsa -N etri1234!

echo service ssh start >> /root/.bashrc

docker exec pgsql-master su - postgres -c "psql -U etri -d etri -p 5432 -c \"create user repl replication password 'etri1234!';\""

docker exec pgsql-master su - postgres -c "psql -U etri -d etri -p 5432 -c \"SELECT * FROM pg_create_physical_replication_slot('repl_slot_01');\""

sudo docker restart pgsql-master
