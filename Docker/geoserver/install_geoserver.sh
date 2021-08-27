sudo docker volume create geoserver_home

sudo docker run -d --restart unless-stopped --name postgis_db \
        -e TZ=Asia/Seoul \
        -e DEFAULT_ENCODING='UTF8' \
        -e POSTGRES_USER=selabdev \
        -e POSTGRES_PASSWORD=qhdkscjfwj\!@ \
        -v /docker_data/geoserver/postgis_data:/var/lib/postgresql \
        -v /docker_data/geoserver/postgis_config:/etc/postgresql/config \
        -p 5434:5432 \
        kartoza/postgis:13

sudo docker volume create pgadmin4

sudo docker run -d --restart unless-stopped --name geo_pgadmin \
        -e TZ=Asia/Seoul \
        -p 83:80 \
        -e 'PGADMIN_DEFAULT_EMAIL=selabdev.selab@selab.co.kr' \
        -e 'PGADMIN_DEFAULT_PASSWORD=qhdkscjfwj!@' \
        -v pgadmin4:/var/lib/pgadmin \
        dpage/pgadmin4:4.27



sudo docker run -d --restart unless-stopped --name geoserver \
        -e TZ=Asia/Seoul \
        -e SAMPLE_DATA=true \
        -e GEOSERVER_ADMIN_USER='selabdev' \
        -e GEOSERVER_ADMIN_PASSWORD='qhdkscjfwj!@' \
        --link postgis_db:postgis_db \
        -v geoserver_home:/opt/geoserver/data_dir \
        -p 8083:8080 \
        kartoza/geoserver:2.19.2
