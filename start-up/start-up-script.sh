# With this instructions all cmds will be running on the "reboot", "start-up".

#=============================================================================
# add the "trigger" for a script run at every reboot on this server

sudo sed -i s/"exit 0"/""/g /etc/rc.local

echo -e "\n# run every time this server is restarted \n ~/start-up.sh || exit 1 \n" | sudo tee -a /etc/rc.local

echo "exit 0" | sudo tee -a /etc/rc.local

cd ~/

#=============================================================================

sudo tee <<'EOF'>>  ~/start-up.sh
#!/bin/bash

echo pass1234 | passwd ec2-user --stdin

exit
EOF

#=============================================================================
sudo chmod +x  ~/start-up.sh
