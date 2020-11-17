#!/bin/bash
# https://github.com/jenkinsci/docker/blob/master/README.md 참고

docker pull jenkins/jenkins:lts

docker volume create jenkins_home

docker run -d --restart unless-stopped --name jenkins-master  \
  -e TZ=Asia/Seoul \
  -v jenkins_home:/var/jenkins_home \
  -p 8080:8080 -p 50000:50000 \
  jenkins/jenkins:lts

sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp
sudo firewall-cmd --permanent --zone=public --add-port=50000/tcp
sudo firewall-cmd --reload
