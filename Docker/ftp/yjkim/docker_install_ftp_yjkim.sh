# https://hub.docker.com/r/fauria/vsftpd

# TODO yjkim : 기본 로그 파일 로그정보가 별로 안남아서 로그 레벨 조정이 필요
docker run -d --restart unless-stopped --cpus=1 \
  --name vsftpd \
  -p 20:20 -p 21:21 -p 21100-21110:21100-21110 \
  -e PASV_MIN_PORT=21100 \
  -e PASV_MAX_PORT=21110 \
  -e TZ=Asia/Seoul \
  -e FTP_USER=selabdev -e FTP_PASS='password' \
  -e LOG_STDOUT=enable  \
  -e XFERLOG_STD_FORMAT=YES \
  fauria/vsftpd:latest