#!/bin/bash

# With this instructions all cmds will be running on the "reboot", "start-up".

echo $(whoami) | sudo tee /tmp/test.txt

#=============================================================================
# add the "trigger" for a script run at every reboot on this server

sudo sed -i s/"exit 0"/""/g /etc/rc.local

echo -e "\n# run every time this server is restarted \n ~/start-up.sh || exit 1 \n" | sudo tee -a /etc/rc.local

echo "exit 0" | sudo tee -a /etc/rc.local

cd ~/

#=============================================================================

sudo tee <<'EOF'>>  ~/start-up.sh
#!/bin/bash

# ========================================================
# ADD a User on Ubuntu
# useradd -h
sudo useradd -p $(openssl passwd -1 paSSword123) -s /bin/bash -m newuser

# ========================================================
# ALLOW USER SSH WITH PQD
sudo sed -i s/"PasswordAuthentication no"/"PasswordAuthentication yes"/ /etc/ssh/sshd_config

# centos
sudo service sshd restart

# ubuntu
sudo service ssh restart


exit
EOF

#=============================================================================
sudo chmod +x  ~/start-up.sh
