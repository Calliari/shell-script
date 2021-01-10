#!/bin/bash


# update the server
sudo apt-get update -y

# Install "mailutils" software email service
sudo apt-get install mailutils -y

# https://gist.github.com/codekipple/688b3f4f8ec00eb0c0c4
# sudo vi /etc/resolv.conf
# nameserver 8.8.8.8
# Then you'll need to restart postfix:
# sudo /etc/init.d/postfix restart

# configuration for postfix
# sudo vim /etc/postfix/main.cf
# sudo service postfix restart

# send email form the terminal with shell cmd
# echo 'message body' |  subject email  -r 'sender'  destination 'test@gmail.com'
echo 'test body' | mail -s "test subject" -r 'test@example.com' test@gmail.com
