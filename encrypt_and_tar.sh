#!/bin/bash

# REFERENCE 
#https://www.shellhacks.com/encrypt-decrypt-file-password-openssl/
#https://www.tecmint.com/encrypt-decrypt-files-tar-openssl-linux/


echo "hello word" > file_to_be_encrypted.txt

# THE ARCHIVE WILL BE CREATED WITH ENCRYPTION (this is the defalt password 'PASS')
# encrypt (tar -czf - file_to_be_encrypted.txt | openssl enc -e -aes256 -out secured.tar.gz -k PASS)
# decrypt (openssl enc -d -aes256 -in secured.tar.gz -k PASS | tar xz -C .)



# NO ENCRYPTION (just normal conpress with tar)
echo "hello word" > file_to_be_compressed.txt
tar -zcvf file_to_be_compressed.txt file_to_be_compressed.txt.tar.gz
