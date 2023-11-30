#!/bin/bash

# REFERENCE 
#https://www.shellhacks.com/encrypt-decrypt-file-password-openssl/
#https://www.tecmint.com/encrypt-decrypt-files-tar-openssl-linux/
#https://coderwall.com/p/tlec0g/openssl-encrypted-tar-backups-for-unix-like-s


echo "hello word" > file_to_be_encrypted.txt

# Deprecated openssl CMD
# THE ARCHIVE WILL BE CREATED WITH ENCRYPTION (this is the defalt password 'PASS')
# encrypt (tar -czf - file_to_be_encrypted.txt | openssl enc -e -aes256 -out secured.tar.gz -k PASS)
# decrypt (openssl enc -d -aes256 -in secured.tar.gz -k PASS | tar xz -C .)

# strong encryption
encrypt (cat secured.tar.gz | openssl enc -e -pbkdf2 -aes256 -out secured.tar.gz -k PASS)
decrypt (openssl enc -d -pbkdf2 -aes256 -in secured.tar.gz -k PASS | tar xz -C .)

# strong description method 2
#encrypt
sudo tar czf - /dir_to_encript | openssl enc -e -aes-256-cbc -pbkdf2 -out /tmp/destination_dir_enc.$(date +"%Y-%m-%d").tgz -k PASSWORD-HERE
#decrypt
openssl enc -d -aes-256-cbc -pbkdf2 -in /tmp/destination_dir_enc.$(date +"%Y-%m-%d").tgz -k PASSWORD-HERE | tar zxf -


# NO ENCRYPTION (just normal conpress with tar)
echo "hello word" > file_to_be_compressed.txt
tar -zcvf file_to_be_compressed.txt file_to_be_compressed.txt.tar.gz
