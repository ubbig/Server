#!/bin/bash
# https://hub.docker.com/r/ngrinder/controller/

docker pull ngrinder/controller:3.5.2
docker pull ngrinder/agent:3.5.2

docker run -d -v /docker_data/ngrinder-controller:/opt/ngrinder-controller --name ngrinder-controller -p 80:80 -p 16001:16001 -p 12000-12009:12000-12009 ngrinder/controller:3.5.2
docker run -d --name ngrinder-agent --link ngrinder-controller:controller ngrinder/agent:3.5.2