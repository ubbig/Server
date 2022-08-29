# ex) $ sh install_ngrinder_agent.sh 192.168.100.3

controllerHost=$1

docker run -d --restart unless-stopped --name ngrinder-agent -e TZ=Asia/Seoul ngrinder/agent:3.5.5-p1 $controllerHost