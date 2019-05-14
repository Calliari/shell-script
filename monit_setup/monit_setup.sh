#!/bin/bash

# Monit GUI
# https://guides.wp-bullet.com/install-latest-monit-ubuntu-16-04-later/

# to send sms 
# https://www.howtoforge.com/configure-monit-to-send-sms-instead-of-email

# instructions on how to install, send email and restart service with monit

# update the server
sudo apt-get update -y


# install monit on ubuntu
sudo apt-get install monit -y

# save the monitcr original file in case need later for references
sudo mv /etc/monit/monitrc /etc/monit/monitrc.orig
sudo chmod 0700 monitrc

#send email when trigger the conditional event
#"alert email to User" configuration block in /etc/monit/monitrc

sudo tee /etc/monit/monitrc <<EOF
# Allow the email be sent through
set mailserver localhost
set mail-format {
     from: monit@$HOST
  subject: monit alert --  $EVENT $SERVICE
  message: $EVENT Service $SERVICE
               Client:      {{client_name_alert_monit}}
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
EOF

#==========================================================
# restart a service when the condition is achieved
#php monitoring" configuration block in "/etc/monit/conf.d/php7.0-fpm"
sudo tee /etc/monit/conf.d/php7.1-fpm <<EOF
check process php7.1-fpm with pidfile /var/run/php/php7.1-fpm.pid
	start program = "/etc/init.d/php7.1-fpm start" with timeout 10 seconds
	stop program = "/etc/init.d/php7.1-fpm stop"
     
     ## chosse which of is configured on the server (port-9000 OR PHP socket)
     # check the port
	if failed host 127.0.0.1 port 9000 type tcp for 2 cycles then restart
     
     # check the socket
     if failed unixsocket /run/php/php7.1-fpm.sock then restart
EOF

sudo chown root:root /etc/monit/conf.d/php7.1-fpm

#==========================================================
#"cpu-usage monitoring" configuration block in "/etc/monit/conf.d/cpu-usage"
sudo tee /etc/monit/conf.d/cpu-usage <<EOF
check system $HOST
	if cpu > 65% for 2 cycles then exec /usr/bin/sudo /bin/sh -c '/etc/init.d/php7.1-fpm force-reload'
	if cpu > 90% for 1 cycles then exec /usr/bin/sudo /bin/sh -c '/etc/init.d/php7.1-fpm restart'
	if cpu > 90% for 1 cycles then exec /usr/bin/sudo /bin/sh -c '/usr/bin/tail -20 /var/log/monit.log > /tmp/last_20_lines_monit_cpu_90.log'
	if cpu > 98% for 2 cycles then exec /usr/bin/sudo /bin/sh -c '/etc/init.d/nginx restart'
	if cpu > 98% for 2 cycles then exec /usr/bin/sudo /bin/sh -c '/usr/bin/tail -20 /var/log/monit.log > /tmp/last_20_lines_monit_cpu_98.log'
EOF
sudo chown root:root /etc/monit/conf.d/cpu-usage

#"file monitoring" configuration block in "/etc/monit/conf.d/file-monitoring"
sudo tee /etc/monit/conf.d/file-monitoring <<EOF
check file with path /tmp/file.txt
  if does not exist then alert

EOF
sudo chown root:root /etc/monit/conf.d/file-monitoring 

#==========================================================
#" nginx monitoring" configuration block in "/etc/monit/conf.d/nginx"
sudo tee /etc/monit/conf.d/nginx <<EOF
check process nginx with pidfile /var/run/nginx.pid
    group www
    group nginx
    start program = "/etc/init.d/nginx start"
    stop program = "/etc/init.d/nginx stop"
    if failed port 80 protocol http request "/" then restart
    if 5 restarts with 5 cycles then timeout
    depend nginx_bin
    depend nginx_rc

check file nginx_bin with path /usr/sbin/nginx
    group nginx
    include /etc/monit/templates/rootbin

check file nginx_rc with path /etc/init.d/nginx
    group nginx
    include /etc/monit/templates/rootbin

EOF
#==========================================================
check host solrcloud.eu-west-1.elb.amazonaws.com with address solrcloud.eu-west-1.elb.amazonaws.com
    if failed url
      http://solrcloud.eu-west-1.elb.amazonaws.com:8983/solr/#/
    then exec /usr/bin/sudo /bin/sh -c '/etc/init.d/solr restart'

    if failed url
      http://solrcloud.eu-west-1.elb.amazonaws.com:8983/solr/#/
    then exec /usr/bin/sudo /bin/sh -c '/usr/bin/tail -20 /var/log/monit.log > /tmp/solr-cloud.log'

#==========================================================

