#!/bin/bash

# to send sms 
# https://www.howtoforge.com/configure-monit-to-send-sms-instead-of-email

# instructions on how to install, send email and restart service with monit

# update the server
sudo apt-get update -y


# install monit on ubuntu
sudo apt-get install monit -y

# save the monitcr original file in case need later for references
sudo mv /etc/monit/monitrc /etc/monit/monitrc.orig

#send email when trigger the conditional event
#"alert email to User" configuration block in /etc/monit/monitrc

sudo tee /etc/monit/monitrc <<EOF
# Allow the email be sent through
set mailserver localhost
set mail-format {
     from: monit@$HOST
  subject: monit alert --  $EVENT $SERVICE
  message: $EVENT Service $SERVICE
                Date:        $DATE
                Action:      $ACTION
                Host:        $HOST
                Description: $DESCRIPTION
                Service name: $SERVICE
           Your faithful employee,
           Monit
}
## --8<--
##
## You can override this message format or parts of it, such as subject
## or sender using the MAIL-FORMAT statement. Macros such as $DATE, etc.
## are expanded at runtime. For example, to override the sender, use:
#
# set mail-format { from: monit@foo.bar }
#
#
## You can set alert recipients whom will receive alerts if/when a
## service defined in this file has errors. Alerts may be restricted on
## events by using a filter as in the second example below.
#
# set alert sysadm@foo.bar                       # receive all alerts
# set alert manager@foo.bar only on { timeout }  # receive just service-
#                                                # timeout alert
set alert technicalalerts+monit@gmail.net
EFO

# restart a service when the condition is achieved
#php monitoring" configuration block in "/etc/monit/conf.d/php7.0-fpm"
sudo tee /etc/monit/conf.d/php7.0-fpm <<EOF
check process php7.0-fpm with pidfile /var/run/php/php7.0-fpm.pid
    start program = "/etc/init.d/php7.0-fpm start" with timeout 30 seconds
    stop program = "/etc/init.d/php7.0-fpm stop"
    if mem usage > 85% for 2 cycles then restart
    if failed unixsocket /run/php/php7.0-fpm.sock then restart
EOF

sudo chown root:root /etc/monit/conf.d/php7.0-fpm

#"cpu-usage monitoring" configuration block in "/etc/monit/conf.d/cpu-usage"
sudo tee /etc/monit/conf.d/cpu-usage <<EOF
check system $HOST
    if cpu usage > 75% for 2 cycles then alert
EFO
sudo chown root:root /etc/monit/conf.d/cpu-usage
