Docker FTP 설치 실행 전 설정

* run_docker_ftp.sh 파일 설정
1. FTP_USER, FTP_PASS 설정
2. -p 포트번호 설정

-- ftp 추가 계정 생성 --
docker exec QI4A_ftp_server sh -c "mkdir /home/vsftpd/devdir"
docker exec QI4A_ftp_server sh -c "echo -e devdir >> /etc/vsftpd/virtual_users.txt"
docker exec QI4A_ftp_server sh -c "echo -e qhdkscjfwj12 >> /etc/vsftpd/virtual_users.txt"
docker exec QI4A_ftp_server sh -c "/usr/bin/db_load -T -t hash -f /etc/vsftpd/virtual_users.txt /etc/vsftpd/virtual_users.db"

* Dockerfile 파일 설정
PASV_MIN_PORT 포트 설정
PASV_MAX_PORT 포트 설정
