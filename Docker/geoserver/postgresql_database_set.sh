#database 생성
psql -U postgres -h 192.168.100.7 -p 5434 -c "CREATE DATABASE landslidencam ENCODING 'UTF-8' LC_COLLATE 'en_US.UTF-8' LC_CTYPE 'en_US.UTF-8'"
#database 연결
psql -U postgres -h 192.168.100.7 -p 5434 -c "\connect landslidencam"
#database 확장자 추가
psql -U postgres -h 192.168.100.7 -p 5434 -c "CREATE EXTENSION postgis"
psql -U postgres -h 192.168.100.7 -p 5434 -c "CREATE EXTENSION hstore"