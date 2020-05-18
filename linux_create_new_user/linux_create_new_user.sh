#!/bin/bash

# Author O. Caliari
# Script to add adn allow ssh access using passwd
#

# ubuntu & centos
sudo sed -i s/"PasswordAuthentication no"/"PasswordAuthentication yes"/ /etc/ssh/sshd_config

# centos
sudo service sshd restart

# ubuntu
sudo service ssh restart

# ======== Random ID ================================================
# ADD a User on Ubuntu (random ID)
# useradd -h
sudo useradd -p $(openssl passwd -1 paSSword123) -s /bin/bash -m newuser
echo "User: newuser"
echo "Passwd: paSSword123"

# add a newuser to "sudo group"
# sudo usermod -aG sudo newuser
# sudo visudo
# newuser ALL=(ALL:ALL) ALL

# ========= Specific ID ===============================================
# ADD a User on Ubuntu (with a specific ID)
sudo useradd -u 1500 newuser
# the ID can be verified with a cmd
id -u newuser

# ========= Create a user with Specific group===========================
# adding a username 'newuser' to a primary-group(users) and secondary-groups(group-1, group-2 and developers)
sudo useradd -g users -G group-1,group-2,developers newuser

# ========================================================
# DELETE a User and home dir on Ubuntu
# deluser -h
# sudo deluser --remove-home newuser
# sudo userdel newuser
# sudo deluser newuser
# ========================================================

# test the ssh connection with username@server-ip E.X
ssh newuser@1.2.3.4 # type the pwd
