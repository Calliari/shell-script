#!/bin/bash

# update this server
sudo apt-get -y update

# Add a swap memory

# Create a Swap File on "/swapfile" location with 2 Gigabyte file
sudo dd if=/dev/zero of=/swapfile bs=1024K count=2048
# sudo fallocate -l 2G /swapfile

# check if the swapfile has the correct 2G of memory allocated by the previous cmd
# ls -lh /swapfile

# Enabling the Swap File
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

# Make the Swap File Permanent
# sudo vim  /etc/fstab
# and add this
# /swapfile   none    swap    sw    0   0
echo -e "/swapfile   none    swap    sw    0   0" | sudo tee -a /etc/fstab

echo -e "\nvm.swappiness=20 \nvm.vfs_cache_pressure=50" | sudo tee -a /etc/sysctl.conf
# vm.swappiness=20
# vm.vfs_cache_pressure=50

#========
# turn off and delete the swapfile
# sudo swapoff /swapfile
# sudo rm -rf /swapfile
