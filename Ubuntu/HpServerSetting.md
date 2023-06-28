## 1. Hp server BIOS setting
 remove secure boot\
 remove fast boot\
 change  UEFI storage setting as AHCI 

## 2. ubuntu network Setting
sudo apt udpate\
sudo apt install net-tools\
sudo vi /etc/netplan/**.config

    network:
      ethernets:
        eno1:
          dhcp4: no
          addresses: 
            - 192.168.100.16/16   # 사용하고자 하는 IP 주소를 CIDR 표기법으로 기재. C-Class는 끝에 '/24' 기입.
          nameservers: 
            addresses: [192.168.100.33, 168.126.63.1] 
          routes:
            - to: default
              via : 192.168.0.1

sudo netplan apply\
sudo systemctl status ssh\
sudo ufw allow ssh
