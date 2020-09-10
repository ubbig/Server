rem 변경전 버전 확인
wsl -l -v

rem wsl_update_x64.msi 설치할 것

rem 업그레이드 명령 실행
wsl --set-version Ubuntu-18.04 2

rem 결과조회
wsl -l -v