#!/usr/bin/env bash

docker pull tomcat:9.0-jdk11-adoptopenjdk-hotspot

docker run -dit --restart unless-stopped --name tomcat9 -p 8080:8080 tomcat:9.0-jdk11-adoptopenjdk-hotspot

sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp
sudo firewall-cmd --reload