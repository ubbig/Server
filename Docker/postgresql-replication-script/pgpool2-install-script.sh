sudo mkdir -p /docker/pgpool/

docker run -d --restart unless-stopped --name pgpool-selab \
       	-e POSTGRES_PASSWORD=selab1234 \
       	-v /docker/pgpool/postgresql:/var/lib/postgresql/data \
       	-v /docker/pgpool/pgpool:/etc/pgpool2 \
      	-p 5555:5555 \
	-p 5557:5557 \
	-p 5558:5558 \
	-p 5556:22 \
       	-e TZ=Asia/Seoul pgpool-selab

#sudo cp config/h-config/* /docker/pgpool/postgresql/
#sudo cp config/pgpool-config/* /docker/pgpool/pgpool/

#docker run -dt --name pgpool-selab -d pgpool-selab:latest
