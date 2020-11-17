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


#docker pull jenkins/slave:4.6-1

#docker volume create jenkins-agent-workdir
#docker run -i --rm --name jenkins-agent \
#  -e TZ=Asia/Seoul \
#  --init -v jenkins-agent-workdir:/home/jenkins/agent jenkins/agent:latest-jdk11 java -jar /usr/share/jenkins/agent.jar -workDir /home/jenkins/agent


#docker container exec -it jenkins-master ssh-keygen -t rsa
#docker container exec -it jenkins-master cat /var/jenkins_home/.ssh/id_rsa.pub
