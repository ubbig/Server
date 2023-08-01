## 1. Hp server BIOS setting

> HP Z2 SFF G9 워크스테이션의 Ubuntu 22.04 를 설치할 때, Ubuntu에서 DISK를 인식하지 못하는 이슈가 있어 아래와 같은 BIOS 설정이 필요함

- F2 연타
- BIOS 설정 > Advanced tab > Boot Options > UEFI Boot Order > Windows Boot Manager를 내리기 > USB: 가장 위로 올리기 > 저장 


## 2. Ubuntu 22.04 network Setting

- `sudo apt update`
- `sudo apt install net-tools`
- `sudo vi /etc/netplan/**config.yaml`

```yaml
# /etc/netplan/**config.yaml
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
```

- `sudo netplan apply`
- `sudo systemctl status ssh`
- `sudo ufw allow ssh`
