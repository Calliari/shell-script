#!/bin/bash

# With this instructions all cmds will be running on the "reboot", "start-up".

echo $(whoami) | sudo tee /tmp/test.txt

# ========================================================
# ALLOW USER SSH WITH PWD (UBUNTU & CENTOS)
sudo sed -i s/"PasswordAuthentication no"/"PasswordAuthentication yes"/ /etc/ssh/sshd_config

#=============================================================================
# UBUNTU
# add the "trigger" for a script run at every reboot on this server

sudo chmod +x /etc/rc.local
sudo sed -i s/"exit 0"/""/g /etc/rc.local
echo -e "\n# run every time this server is restarted \n ~/start-up.sh || exit 1 \n" | sudo tee -a /etc/rc.local
echo "exit 0" | sudo tee -a /etc/rc.local

# CENTOS
sudo chmod +x /etc/rc.d/rc.local
sudo sed -i s/"exit 0"/""/g /etc/rc.d/rc.local
echo -e "\n# run every time this server is restarted \n ~/start-up.sh || exit 1 \n" | sudo tee -a /etc/rc.d/rc.local
echo "exit 0" | sudo tee -a /etc/rc.d/rc.local

#=============================================================================

sudo tee <<'EOF'>>  ~/start-up.sh
#!/bin/bash

# ========================================================
# ADD a User on Ubuntu
# useradd -h
sudo useradd -p $(openssl passwd -1 paSSword123) -s /bin/bash -m newuser

#         CENTOS          or        UBUNTU 
sudo service sshd restart || sudo service ssh restart


exit
EOF

#=============================================================================
sudo chmod +x  ~/start-up.sh
