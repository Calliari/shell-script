#!/bin/bash


# install s3fs

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install s3fs -y
sudo apt-get update -y


# # mount a s3fs on a ec2, notes:
mkdir /new_directory
chmod 777 new_directory

# echo "accessKeyId:secretAccessKey" > ~/.passwd-s3fs
# sudo chmod 600 ~/.passwd-s3fs

# The s3 user with the "accessKeyId" credentioal above must have the correct permissions to mount s3fs
sudo s3fs S3_bucket -o use_cache=/tmp  /new_directory -o allow_other,uid=33,gid=33,umask=007

