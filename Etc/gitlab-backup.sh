#!/bin/bash

echo ""
echo "GitLab Backup Shell: `date`"

BACKUP_DIR=/var/opt/gitlab/backups
MOUNT_DIR=/media/backup/GITLAB
echo "[1/2] gitlab-rake gitlab:backup:create ..."

gitlab-rake gitlab:backup:create

echo "Done."

#################################
## Move backup file to NAS(NFS)
#################################
#echo "[1/1] Done."
#echo "[2/2] mv $BACKUP_DIR/*.tar $MOUNT_DIR"
#cd $BACKUP_DIR
#mv *.tar $MOUNT_DIR
#echo "[2/2] Done."
