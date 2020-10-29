#!/bin/bash

# https://github.com/SELabInc/docker-openvpn 참고함
# 공유기 1194/UDP 포트포워딩 할 것

OVPN_DATA="ovpn-data-volume"
docker volume create --name $OVPN_DATA

docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm kylemanna/openvpn ovpn_genconfig -u udp://www.qi4a.com
docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm -it kylemanna/openvpn ovpn_initpki
# 공용키 사용하여 생성

docker run -d --restart unless-stopped -v ovpn-data-volume:/etc/openvpn -p 1194:1194/udp --cap-add=NET_ADMIN kylemanna/openvpn
# 에러 발생시 아래 내용 실행할 것 (iptables v1.4.14: can't initialize iptables table `nat': Table does not exist)
# sudo modprobe ip_tables
# sudo echo 'ip_tables' >> /etc/modules
docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm -it kylemanna/openvpn easyrsa build-client-full selabdev nopass

# vpn키생성하고 사용자에게 배포
docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm kylemanna/openvpn ovpn_getclient selabdev > selabdev.ovpn
