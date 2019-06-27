# With this instructions all cmds will be running on the "reboot", "start-up".

#=============================================================================
# add the "trigger" for a script run at every reboot on this server

sudo sed -i s/"exit 0"/""/g /etc/rc.local

echo -e "\n# run every time this server is restarted \n/home/ubuntu/start-up.sh || exit 1 \n" | sudo tee -a /etc/rc.local

echo "exit 0" | sudo tee -a /etc/rc.local



#=============================================================================

sudo tee <<'EOF'>> /home/ubuntu/start-up.sh
#!/bin/bash

echo pass1234 | passwd ec2-user --stdin

exit
EOF

#=============================================================================
sudo chmod +x /home/ubuntu/start-up.sh
