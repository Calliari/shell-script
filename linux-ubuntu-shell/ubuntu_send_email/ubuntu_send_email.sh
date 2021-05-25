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


###### ====== #####
# exim4
# getting the LOGS
cat /var/log/exim4/mainlog

#Stop - start - restart fromi the exim4 binary
sudo /etc/init.d/exim4 stop
sudo /etc/init.d/exim4 start
sudo /etc/init.d/exim4 restart


#In case errors - good to remove these files from "exim4"
sudo ls -lsa /var/spool/exim4/db/* # check the files
sudo rm -rf /var/spool/exim4/db/* # remove the files


# Block the emails to be sent with underscores
# *:apikey:KK.YYYYYYYYY-yyyy.XXXXxxzzz123
# *:apikey:KK.YYYYYYYYY-yyyy.XXXXxxzzz123_____
sudo vim /etc/exim4/passwd.client # adding "_____" (5 underscores) at the end line to block it

########### === Reference === ################ 
#1. Take backup of “/var/spool/exim/db/” directory in case if there is other problems, so we can revert...
#2. Stop exim service using following command

#root@server[#] /etc/init.d/exim stop

#3. Now delete the ratelimit & retry files

#root@server[#] rm -rf ratelimit
#root@server[#] rm -rf retry
#or
#root@server[#] rm -rf *

#4. Start the exim service

#root@sever[#] /etc/init.d/exim start
#it will rebuild the Exim Database
