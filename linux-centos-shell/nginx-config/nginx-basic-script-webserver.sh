#! /bin/bash

#
sudo yum update -y

# OPEL - if centos core linux
sudo yum install -y epel-release 
# OPEL - if centos amazon linux 
sudo amazon-linux-extras install -y epel

sudo yum update -y 

#
sudo yum install -y nginx

#
sudo systemctl start nginx
sudo systemctl enable nginx

#
sudo systemctl status nginx
#
sudo systemctl reload nginx
#
sudo systemctl restart nginx


## Configuration test 
sudo nginx -t
