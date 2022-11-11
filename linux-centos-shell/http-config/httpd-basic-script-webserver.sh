#!/bin/bash

sudo yum -y update httpd

sudo yum -y install httpd

# if firewalld is installed on the server it needs to open up port 80 to allow Apache to serve requests over HTTP and/or HTTPS
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --reload


sudo systemctl start httpd
sudo systemctl enable httpd
sudo systemctl status httpd
