#!/bin/bash

# WSL용 ssh는 설치방법이 특이하다. https://www.tuwlab.com/ece/29302 참고
# https://www.tuwlab.com/29342

sudo /usr/bin/ssh-keygen -A

sudo apt update
sudo apt upgrade -y

sudo apt purge -y openssh-server
sudo apt install -y openssh-server
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config

sudo service ssh --full-restart
sudo service ssh restart

sudo bash -c "sudo cat >> /etc/sudoers << EOF
%sudo ALL=NOPASSWD: /usr/sbin/service
EOF"

# ssh키 복사 후 실행권한 조정
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub
chmod 644 ~/.ssh/authorized_keys
chmod 644 ~/.ssh/known_hosts

# WSL2로 가면서 외부에서 접속하려면 포트포워딩이 필요해짐
# https://www.hanselman.com/blog/how-to-ssh-into-wsl2-on-windows-10-from-an-external-machine 참고

# cmd 관리자 권한 실행 후 실행(WSL상의 네트워크 ip주소 확인 후 powershell스크립트를 관리자권한으로 실행한다.)
#ipaddr=$(hostname -I)

#netsh interface portproxy add v4tov4 listenaddress=0.0.0.0 listenport=22 connectaddress=172.23.244.182 connectport=22
#netsh advfirewall firewall add rule name="Open Port 22 for WSL2" dir=in action=allow protocol=TCP localport=22

# ssh_start.bat파일을 시작프로그램에 등록(실행 -> shell:startup순으로 실행하여 시작프로그램 실행 후 스크립트 복사할 것)