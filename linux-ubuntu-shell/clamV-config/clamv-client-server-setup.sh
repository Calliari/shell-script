#!/bin/bash

# CLAMV-SERVER CONFIG
# updates
sudo apt update -y

# Hostname
HOSNAME="clamv-server"

# Timezone
TIMEZONE="Europe/London"

# Install PKG 
INSTALL_PACKAGES=(
aptitude
zip
unzip
software-properties-common
software-properties-common
unattended-upgrades
cowsay
htop
clamav-daemon 
clamav
)

###### Starting implementing the changes/updateds based on the variables assigned ####

# hostname
sudo sed -i s/"ip"/"$HOSNAME"/ /etc/hostname
sudo hostname $(cat /etc/hostname)

# timedatectl list-timezones
sudo timedatectl set-timezone "$TIMEZONE"
echo "$TIMEZONE" | sudo tee /etc/timezone
sudo dpkg-reconfigure --frontend noninteractive tzdata

# install packages
sudo apt-get -y update; 
for INSTALL_PACKAGE in "${INSTALL_PACKAGES[@]}"; do
  echo -e "----- Installing... $INSTALL_PACKAGE ----- \n";
  sudo apt-get install -y "$INSTALL_PACKAGE";
done; 

## After all configuration is implemented and bootstrap the server is done
# sudo service clamav-daemon stop

## Reconfigure the clamv-server PORT (TCPSocket 3310) - https://linux.die.net/man/5/clamd.conf
# sudo vim /etc/clamav/clamd.conf
# sudo service clamav-daemon restart


# CLAMV-CLIENT CONFIG
## Client config install clamdscan and removing extra - no needed in the client server
# sudo apt install -y clamdscan
# sudo apt remove -y clamav-daemon clamav-freshclam
# sudo apt autoremove -y

# configure the clamv-server TCPAddr and TCPSocket (TCPAddr 1.2.3.4 TCPSocket 3310) and remove (LocalSocket) - https://linux.die.net/man/5/clamd.conf
# sudo vim /etc/clamav/clamd.conf

## test the connection from the client
# clamdscan [*options*] [*file/directory/-*]
# echo 'X5O!P%@AP[4\PZX54(P^)7CC)7}$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$H+H*' > ~/infected-file.txt
# clamdscan -v ~/infected-file.txt
# clamdscan
