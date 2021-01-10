#!/bin/bash


# automysqlbackup create dir
mkdir -p /usr/local/share/automysqlbackup/
mkdir -p /usr/sbin/bin/

# download automysqlbackup from source
wget -P /usr/local/share/automysqlbackup/ https://sourceforge.net/projects/automysqlbackup/files/latest/download/automysqlbackup-v3.0_rc6.tar.gz

# extract the automysqlbackup tar file
sudo tar -zxvf /usr/local/share/automysqlbackup/automysqlbackup-v3.0_rc6.tar.gz -C /usr/local/share/automysqlbackup/

# synclink /usr/sbin/bin/automysqlbackup ==> /usr/local/share/automysqlbackup
sudo ln -s /usr/local/share/automysqlbackup /usr/sbin/bin/automysqlbackup

# make this files executable automysqlbackup install.sh
sudo chmod +x /usr/local/share/automysqlbackup/install.sh /usr/local/share/automysqlbackup/automysqlbackup

# Install automysqlbackup from the Install.sh file
cd /usr/local/share/automysqlbackup
sudo /usr/local/share/automysqlbackup/install.sh
cd

# replace lines in this file "/etc/automysqlbackup/automysqlbackup.conf"

# take the end point database connection as whole string
DB_ENDPOINT=${database_dns_endpoint}

# remove the last 5 characters from database end point (:3306)
database_dns=$${DB_ENDPOINT:: -5}

sudo sed -i s/"#CONFIG_mysql_dump_username='root'"/"CONFIG_mysql_dump_username='${dbuser}'"/g /etc/automysqlbackup/automysqlbackup.conf
sudo sed -i s/"#CONFIG_mysql_dump_password=''"/"CONFIG_mysql_dump_password='${dbpass}'"/g /etc/automysqlbackup/automysqlbackup.conf
sudo sed -i s/"#CONFIG_mysql_dump_host='localhost'"/"CONFIG_mysql_dump_host='$database_dns'"/g /etc/automysqlbackup/automysqlbackup.conf
sudo sed -i s/"#CONFIG_backup_dir='\/var\/backup\/db'"/"CONFIG_backup_dir='\/data\/automysqlbackup'"/g /etc/automysqlbackup/automysqlbackup.conf
sudo sed -i s/"#CONFIG_db_exclude=( 'information_schema' )"/"CONFIG_db_exclude=( 'information_schema' 'performance_schema' )"/g /etc/automysqlbackup/automysqlbackup.conf
# sudo sed -i s/"#CONFIG_backup_dir='\/var\/backup\/db'"/"CONFIG_backup_dir='\/tmp\/automysqlbackup'"/g /etc/automysqlbackup/automysqlbackup.conf
sudo sed -i s/"#CONFIG_mysql_dump_usessl='yes'"/"CONFIG_mysql_dump_usessl='no'"/g /etc/automysqlbackup/automysqlbackup.conf
sudo sed -i s/"#CONFIG_mysql_dump_latest='no'"/"CONFIG_mysql_dump_latest='yes'"/g /etc/automysqlbackup/automysqlbackup.conf
sudo sed -i s/"#CONFIG_mysql_dump_latest_clean_filenames='no'"/"CONFIG_mysql_dump_latest_clean_filenames='yes'"/g /etc/automysqlbackup/automysqlbackup.conf


#
# ================================
# automysqlbackup command backups to start
#sudo /usr/local/bin/automysqlbackup > /dev/null 2>&1
