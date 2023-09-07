# Hp Server CentOS 7 설정 가이드
## 1. 설치 환경

* 모델명 :  `HP Z2 SFF G9 Workstation`
* 운영체제 : `CentOS 7.x`


## 2. Booting USB 생성

 1) [Rufus 다운로드](https://rufus.ie/ko/)
 2) [centos ISO 다운로드](http://mirror.kakao.com/centos/)
     - 7.x 버전선택 -> isos -> x86_64 -> CentOS-7-x86_64-DVD-2009.iso 다운로드
 3) Rufus 실행
     - 부팅 선택 : CentOS-7-x86_64-DVD-2009.iso 선택
     - 파티션 구성 : MBR
     - 대상 시스템 : BIOS 또는 UEFI
     - 파일시스템 : FAT32(기본값)

## 3. BIOS 설정
재부팅 후 로고가 나왔을 때 <U>*F3*</U> 또는 <U>*F10*</U> 클릭 (*왼쪽 하단에 선태한 옵션이 텍스트로 표출됨*)
 

### 3.1) BIOS 메뉴 접속 및 설정
### F3 클릭
```
1. Drivers -> Network Device List
2. Network Device List의 Mac 선택
3. IPv4 Network Configuration 선택
4. Mac 선택 -> Configured[X], Enable DHCP [X] 확인
5. 저장
```
### F10 클릭
```
1. security 메뉴
   Secure Boot Configuration -> Secure Boot 체크 해제
2. Advanced 메뉴
   1) System Options -> Configure Storage Controller for VMD 체크 해제
      - Linux 설치 또는 UEFI Boot Order에 디스크가 보이지 않을 때 확인
		
   2) Boot Options
	  -> Fast Boot[ ] 체크 해제
	  -> USB Storage Boot[V] 체크 (리눅스 설치 후 체크 해제)
	  -> Network (PXE) Boot[V] 체크
	  -> IPv6 during UEFI Boot[ ] 체크 해제
	  -> UEFI Boot Order -> 제일 위로 USB로 이동

        USB가 disabled 경우
		  - USB 항목 선택지 위에서 키보드의 f5 클릭
		  - f5가 안먹힐 경우 USB Storage Boot 체크 후 재부팅 하여 바이오스 재진입하여 f5 재시도
```

## 4. Centos 설치
1) 파티션 생성
2) 소프트웨어 선택
   * <U>최소설치의 기본 툴은 선택하는게 좋음</U>
3) 네트워크 선택
   * <U>네트워크 선택지가 나오지 않을 경우 따로 네트워크 드라이브 설치가 필요</U>
4) 설치중 Alter boot device not found 오류 발생시 무시하고 계속 진행


## 5. Network 설정
### 네트워크 설정 문제시 수행 방법 (네트워크 드라이브 설치 문제)
* Centos를 설치 후 네트워크 연결이 되지 않고 /etc/sysconfig/network-script/ 아래 ifcfg-lo 파일만 존재할 때 수행
* [I219-LM 네트워크 드라이브 다운로드](https://www.intel.com/content/www/us/en/download/14611/15817/intel-network-adapter-driver-for-pcie-intel-gigabit-ethernet-network-connections-under-linux-final-release.html?product=71307)
```
tar -zxvf e1000e-3.8.4.tar.gz
cd ./e1000e-3.8.4/src/
make install
modprobe e1000e
```
### 네트워크 드라이브 설치 확인

* 네트워크 드라이브 설치 후 ping 8.8.8.8 로 dhcp 연결 테스트
```
1.ifconfig
2.ping 8.8.8.8
```

### 고정 IP 설정
* ipconfig 로 새로 생성된 Network Interface Name (eno1)으로 파일을 생성
* ifcfg-eno1 생성
```
TYPE="Ethernet"
PROXY_METHOD="none"
BROWSER_ONLY="no"
BOOTPROTO="none"
BEFROUTE="yes"
IPV4_FAILURE_FATAL="yes"
IPV6INT="yes"
IPV6_AUTOCONF="yes"
IPV6_DEFROUTE="yes"
IPV6_FAILURE_FATAL="no"
IPV6_ADDR_GEN_MODE="stable-privacy"
NAME="eno1"
DEVICE="eno1"
ONBOOT="yes"
IPADDR="192.168.100.55"
PREFIX="16"
GATEWAY="192.168.0.1"
DNS1="192.168.100.33"
DNS2="8.8.8.8"
IPV6_PRIVACY="no"
```
### 고정 IP 설정 적용
```
ifup eno1
systemctl restart network
```

## 6. 기타
### 랜카드 정보 확인
```
 lspci | grep -i Ethernet
```

위의 명령어 수행 후  Ethernet controller: Intel Corporation <U>Ethernet Connection (17) I219-LM</U> (rev 11) 로 확인
