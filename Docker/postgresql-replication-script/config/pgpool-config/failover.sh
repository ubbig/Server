#!/bin/bash
# This script is run by failover_command.

set -o xtrace

# Special values:
# 1)  %d = failed node id
# 2)  %h = failed node hostname
# 3)  %p = failed node port number
# 4)  %D = failed node database cluster path
# 5)  %m = new main node id
# 6)  %H = new main node hostname
# 7)  %M = old main node id
# 8)  %P = old primary node id
# 9)  %r = new main port number
# 10) %R = new main database cluster path
# 11) %N = old primary node hostname
# 12) %S = old primary node port number
# 13) %% = '%' character

FAILED_NODE_ID="$1"
FAILED_NODE_HOST="$2"
FAILED_NODE_PORT="$3"
FAILED_NODE_PGDATA="$4"
NEW_MAIN_NODE_ID="$5"
NEW_MAIN_NODE_HOST="$6"
OLD_MAIN_NODE_ID="$7"
OLD_PRIMARY_NODE_ID="$8"
NEW_MAIN_NODE_PORT="$9"
NEW_MAIN_NODE_PGDATA="${10}"
OLD_PRIMARY_NODE_HOST="${11}"
OLD_PRIMARY_NODE_PORT="${12}"

PGHOME=/usr/lib/postgresql/13
REPL_SLOT_NAME=${FAILED_NODE_HOST//[-.]/_}

echo "new_node_id=${NEW_MAIN_NODE_ID}, faild_node_id=${FAILED_NODE_ID}, old_main_node_id=${OLD_MAIN_NODE_ID}, old_primary_node_id=${OLD_RPIMARY_NODE_ID}, new_main_node_host=${NEW_MAIN_NODE_HOST}, date:$(date)" >> /etc/pgpool2/failover.log

if [ ${FAILED_NODE_ID} -eq 0 ]; then
    echo Run : ${FAILED_NODE_ID} to 1 >> /etc/pgpool2/failover.log
    ssh -T postgres@${NEW_MAIN_NODE_HOST} -p 5553 ${PGHOME}/bin/pg_ctl -D /var/lib/postgresql/data -w promote
fi

if [ ${FAILED_NODE_ID} -eq 1 ]; then
    ssh -T postgres@${NEW_MAIN_NODE_HOST} -p 5563 ${PGHOME}/bin/pg_ctl -D /var/lib/postgresql/data -w promote
fi

if [ $? -ne 0 ]; then
    echo ERROR: failover.sh: end: failover failed
    exit 1
fi

echo failover.sh: end: new_main_node_id=$NEW_MAIN_NODE_ID on ${NEW_MAIN_NODE_HOST} is promoted to a primary
exit 0
