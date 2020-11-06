#!/bin/bash

docker pull dpage/pgadmin4

sudo chown -R 5050:5050 /docker_data/pgadmin4/workspace

docker run -d --restart unless-stopped --name pgadmin -p 82:80 -e PGADMIN_DEFAULT_EMAIL=selabdev.selab@gmail.com -e PGADMIN_DEFAULT_PASSWORD=qhdkscjfwj\!@ -v /docker_data/pgadmin4/workspace:/var/lib/pgadmin dpage/pgadmin4

sudo firewall-cmd --permanent --zone=public --add-port=82/tcp
sudo firewall-cmd --reload
