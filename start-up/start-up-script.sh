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
echo -e "\n# run every time this server is restarted \n/root/start-up.sh || exit 1 \n" | sudo tee -a /etc/rc.local
echo "exit 0" | sudo tee -a /etc/rc.local

# CENTOS
sudo chmod +x /etc/rc.d/rc.local
sudo sed -i s/"exit 0"/""/g /etc/rc.d/rc.local
echo -e "\n# run every time this server is restarted \n/root/start-up.sh || exit 1 \n" | sudo tee -a /etc/rc.d/rc.local
echo "exit 0" | sudo tee -a /etc/rc.d/rc.local

#=============================================================================

sudo tee <<'EOF'>> /root/start-up.sh
#!/bin/bash

# ========================================================
# NOTES
# CMD useradd
# ‘-m -d‘ option creates a user with specified home directory
# ‘-s‘ option set the user’s default shell i.e. /bin/bash
# ‘-c‘ option adds the extra information about user (comments)
# ‘-u‘ defines new user’s UID (i.e. 1000)
# ‘-g‘ defines GID (i.e. 1000).
# lastesly the usernaem to be added

#useradd -m -d /var/lib/jenkins/ -s /bin/bash -c "jenkins master from jenkins server" -u 1001 -g 1001 jenkins

# ========================================================
# ADD a User on Ubuntu
# useradd -h
sudo useradd -p $(openssl passwd -1 paSSword123) -s /bin/bash -m newuser

#         CENTOS          or        UBUNTU 
sudo service sshd restart || sudo service ssh restart


exit
EOF

#=============================================================================
sudo chmod +x /root/start-up.sh
