# linux distribution
cat /etc/*release

# cpu info
lscpu

# disk info
lsblk

# ssd 0, hdd 1
lsblk -d -o name,rota

# 명령 결과 모니터링
# watch -n1 [command]
watch -n1 ls -l  # ls -l 결과를 1초마다 출력

# 전체 프로세스 확인
ps aux

# 파일 내용의 마지막 라인 출력
tail -f tomcat/logs/catalina.out     # 실시간으로 마지막 라인 출력
tail -n 10 tomcat/logs/catalina.out  # catalina.out 파일의 마지막 10줄 출력

# cpu 사용량 등 모니터링
top
