#!/bin/bash

#https://jp-hosting.jp/nginx-lets-encrypt%EB%A5%BC-%ED%86%B5%ED%95%B4-nginx%EC%97%90%EC%84%9C-%EB%AC%B4%EB%A3%8C%EB%A1%9C-https-%EC%84%A4%EC%A0%95%ED%95%98%EA%B8%B0/
# 80, 443포트 열려있는지 확인

sudo apt-get update
$ sudo apt-get install software-properties-common
$ sudo add-apt-repository universe
$ sudo apt-get update

sudo apt-get install certbot python3-certbot-nginx

# /etc/nginx/nginx.conf파일에 server_name항목에 도메인 설정할 것
# 예) server_name qi4a.com www.qi4a.com;

sudo nginx -t
sudo service nginx reload

# 인증서 갱신
sudo certbot renew --dry-run