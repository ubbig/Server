#/bin/bash

#mkdir -p /docker/master-backup/
#pg_basebackup -h 172.26.5.114 -p 5452 -U repl -D /docker/master-backup/ -Fp -R -Xs -P
#cp -f /var/lib/postgresql/data/postgresql.conf /docker/master-backup/
#cp -f /var/lib/postgresql/data/pg_hba.conf /docker/master-backup/
#mv -f /docker/master-backup/* /var/lib/postgresql/data/

apt-get update
apt-get install -y vim
apt-get install -y ssh
echo service ssh start >> /root/.bashrc

mkdir master-backup
cp -f /var/lib/postgresql/data/postgresql.conf /master-backup/
cp -f /var/lib/postgresql/data/pg_hba.conf /master-backup/
rm -rf /var/lib/postgresql/data/*
pg_basebackup -h 172.26.5.114 -p 5452 -U repl -D /var/lib/postgresql/data -Fp -R -Xs -P
cp -f /master-backup/postgresql.conf /var/lib/postgresql/data/
cp -f /master-backup/pg_hba.conf /var/lib/postgresql/data/
