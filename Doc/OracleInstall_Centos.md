# 오라클DB 19c 설치 가이드
## 1. 설치 환경
* 운영체제 : `CentOS 7.x`
* 버전 : 19c Oracle Enterprise Edition, 19c Oracle Standard Edition
* GUI 환경 필요

## 2. 설치
다운로드 위치
```
https://www.oracle.com/database/technologies/oracle-database-software-downloads.html
Oracle Database 19c for Linux x86-64
```

## 3. 방화벽 해제
```
systemctl stop firewalld 
```

## 4. 오라클 유저 생성

## 5. 환경설정 추가
1) 생성한 유저로 접속
2) .bash_profile 내용 추가
```
vi ~/.bash_profile
```
```
export TMP=/tmp
export TMPDIR=$TMP
export ORACLE_OWNER=ora19c
export ORACLE_UNQNAME=selab
export ORACLE_HOSTNAME=selab
export ORACLE_BASE=/app/ora19c
export ORACLE_HOME=/app/ora19c/19c
export ORACLE_SID=selab
export DATA_DIR=$ORACLE_HOME/oradata
export PATH=$PATH:$ORACLE_HOME/bin:$ORACLE_HOME:/usr/bin:.
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib
export CLASSPATH=$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib
```
3) 설정 적용
```
source ~/.bash_profile
```

## 6. 다운로드 위치 폴더 생성
export에 설정한 Oracle_HOME으로 지정될 위치
```
 mkdir -p /app/ora19c/19c
```

## 7. 오라클 압축해제
```
unzip 파일명 /app/ora19c/19c
```

## 8. Oracle DB 설치
설치중 네트워크 오류시 재수행 버튼 클릭
```
cd $ORACLE_HIME
./runInstaller
```

## 9. Oracle DB 시작
### 9.1 ) DB 구동
oracle 접속
```
sqlplus / as sysdba
```
시작 및 중지 명령어
```
시작: startup
중지: shutdown
```
### 9.2 ) 오류
startup 오류 발생 (LRM-00109)
```
/app/ora19c/admin/selabdb/prfile/init.ora.* 파일을 /app/ora19c/19c/dbs/initselab.ora로 복사 후 startup
```

## 10. 리스너 등록
### 10.1 ) 리스너 설정
1. 리스너 매니저 접속
```
netmgr
```
2. 리스너 폴더 선택 및 추가
	  - 수신위치 설정  
		-> 호스트 입력 (hostName 또는 ip)  
		-> 포트 입력 (기본: 1521)
	  - 데이터베이스 서비스 설정  
		-> Oracle 홈 디렉토리 입력  
		-> SID 입력 (대소문자 구분 필수)
2. 서비스 이름 지정 선택 및 추가
	  - 서비스 ID  
		-> 서비스 이름 입력 (기본 DB명)
	  - 주소 구성  
		-> TCP/IP  
		-> 호스트 이름 (hostName 또는 ip)  
		-> 포트 입력 (기본: 1521)
3. 리스너 생성 파일 확인
```
path: cd $ORACLE_HOME/network/admin
리스너 파일: listener.ora
서비스 파일: tnsnames.ora
```
5. 주의사항
	  - 호스트 이름 통일 
	  - sid의 대소문자 구분
### 10.2 ) 리스너 명령어
```
lsnrctl start
lsnrctl stop
lsnrctl status
lsnrctl services
```

## 11. 테스트
1. 로컬 접속 테스트  
    - sqlplus 계정/패스워드
    - sqlplus system/oracle
2. 외부 접속 테스트
    - sqlplus 계정/패스워드@호스트명/포트번호
    - sqlplus system/oracle@192.168.100.55/1521
3. 로컬 테스트에서 문제가 없으나 외부 접속 테스트가 불가능 일 때 리스너 설정 문제
    - sid 확인
    - host 확인
    - listener.ora, tnsnames.ora 파일 확인
4. 로컬 및 외부 접속 테스트가 가능하나 외부에서 외부 접속 테스트로 접속이 되지 않을 때
    - 방화벽 확인

    