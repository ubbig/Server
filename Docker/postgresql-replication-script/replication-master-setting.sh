#bin/bash

apt-get update
apt-get install -y vim
apt-get install -y ssh
echo service ssh start >> /root/.bashrc

su - postgres -c "psql -U postgres -d postgres -p 5452 -c \"create user repl replication password 'selab';\""

su - postgres -c "psql -U postgres -d postgres -p 5452 -c \"SELECT * FROM pg_create_physical_replication_slot('repl_slot_01');\""

