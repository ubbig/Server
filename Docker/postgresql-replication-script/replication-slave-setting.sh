#/bin/bash
#실행 후 postgresql.auto.conf 수정

mkdir /master-backup

pg_basebackup -h 203.236.196.185 -p 5434 -U repl -D /master-backup -Fp -R -Xs -P
sleep 1

cp -arpf /var/lib/postgresql/data/postgresql.conf /master-backup/
cp -arpf /var/lib/postgresql/data/pg_hba.conf /master-backup/
cp -arpf /master-backup/* /var/lib/postgresql/data/

