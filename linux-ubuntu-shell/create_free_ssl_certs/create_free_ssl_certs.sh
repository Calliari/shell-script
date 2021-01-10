#!/bin/bash

# ===========================================================================================
##
## DNS record with no questions:
##
# from:
# https://medium.com/@saurabh6790/generate-wildcard-ssl-certificate-using-lets-encrypt-certbot-273e432794d7
# https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-ubuntu-18-04
# ===========================================================================================

# start, update and install the neccessaries packages
sudo apt-get update
sudo apt-get install -y software-properties-common
sudo add-apt-repository universe
sudo add-apt-repository ppa:certbot/certbot
sudo apt-get update
sudo apt-get install -y certbot python-certbot-nginx

# ===========================================================================================
# see cmd help
# sudo certbot certonly --manual
#
## apexand & www-subdomain ssl-only
# sudo certbot-auto certonly --manual --preferred-challenges=dns --email admin@domain.com --agree-tos -d domain.com -d www.domain.com

## wildcard ssl-generation 
# sudo certbot-auto certonly --manual --preferred-challenges=dns --email admin@domain.com --agree-tos --server https://acme-v02.api.letsencrypt.org/directory -d *.domain.com
