#!/bin/bash

# update this server
sudo apt-get -y update


# install rdiff-backup
sudo apt-get install -y rdiff-backup

# add the backups-server to entry host to be easer to pipe data if the ip change, just change it here
echo -e "\n55.25.178.40 backups-server # public ip\n" | sudo tee -a /etc/hosts

# add the config for "root" only, good security practice
sudo tee <<'EOF'>> /root/.ssh/config
host backup-server
        IdentityFile /root/.ssh/backup-server.key
        User ubuntu
EOF


# Add the "backup-server.key" to this server,  hash-key will be done manually (security)
touch /root/.ssh/backup-server.key
chmod 0600 /root/.ssh/backup-server.key

# Add the "ssh hand-shake" output to a /root/.ssh/known_hosts
ssh-keyscan -H backup-server | tee /root/.ssh/known_hosts;

# send these all to backups server
# excluede the "/data/lost+found" 
# send the "/data/*" dir source to "/backups_dir/" dir destination
rdiff-backup --exclude /data/lost+found /data backups-server::/backups_dir/
