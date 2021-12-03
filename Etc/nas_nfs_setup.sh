# ubuntu
sudo apt install nfs-common

sudo mkdir -p /mnt/nas-nfs
sudo chown -R selabdev:selabdev /mnt/nas-nfs

sudo bash -c "sudo cat >> /etc/fstab << EOF
192.168.100.40:/volume1/ServerSharedDrive /mnt/nas-nfs nfs user,rsize=8192,wsize=8192,atime,auto,rw,dev,exec,suid 0 0
EOF"
