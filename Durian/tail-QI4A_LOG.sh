#!/usr/bin/env bash
# QI4A 최근 날짜 로그 조회

ssh selabdev@203.236.196.189 '
log_path=/docker_data/license_server_LogFiles/
tail -f $log_path`ls $log_path | grep QDA- | sort -V | tail -n 1`
'

