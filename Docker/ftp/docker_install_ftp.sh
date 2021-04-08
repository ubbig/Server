#!/usr/bin/env bash

docker build --no-cache  . -t ftp_server

docker rm -f QI4A_ftp_server

docker run --name QI4A_ftp_server --restart unless-stopped -d -v /docker_data/qda_updater_server:/home/vsftpd -e FTP_USER=selabdev -e FTP_PASS=qhdkscjfwj!@ -p 20:20 -p 21:21 -p 21100-21110:21100-21110 ftp_server

sudo firewall-cmd --permanent --zone=public --add-port=20-21/tcp
sudo firewall-cmd --permanent --zone=public --add-port=21100-21110/tcp
sudo firewall-cmd --reload
