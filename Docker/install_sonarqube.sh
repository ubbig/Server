#!/bin/bash

docker pull sonarqube:7.9.3-community

docker run -d --restart unless-stopped --name sonarqube -p 9000:9000 sonarqube:7.9.3-community