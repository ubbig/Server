#!/bin/bash

# https://github.com/vutran/docker-nginx-php5-fpm 참고함
docker run --name nginx_php -d -p 58080:80 -v /docker_data/nginx_php/html:/var/www/html vutran/docker-nginx-php5-fpm