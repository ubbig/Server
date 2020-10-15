#!/bin/bash

# WSL용 ssh는 설치방법이 특이하다. https://www.tuwlab.com/ece/29302 참고
# https://www.tuwlab.com/29342

/usr/bin/ssh-keygen -A

sudo apt update
sudo apt upgrade -y

sudo apt purge -y openssh-server
sudo apt install -y openssh-server

sudo service ssh --full-restart
sudo service ssh restart

sudo bash -c "sudo cat >> /etc/sudoers << EOF
%sudo ALL=NOPASSWD: /usr/sbin/service
EOF"

# WSL2로 가면서 외부에서 접속하려면 포트포워딩이 필요해짐
# https://www.hanselman.com/blog/how-to-ssh-into-wsl2-on-windows-10-from-an-external-machine 참고

# cmd 관리자 권한 실행 후 실행(WSL상의 네트워크 ip주소 확인필요)
netsh interface portproxy add v4tov4 listenaddress=0.0.0.0 listenport=22 connectaddress=172.23.129.80 connectport=22
netsh advfirewall firewall add rule name="Open Port 22 for WSL2" dir=in action=allow protocol=TCP localport=22