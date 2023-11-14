#### This is a grep command to get the lastest "5 ips" from the latest "25 lines" in the log access from the server with nginx as a webserver.
```
grep -e $(date --date="-5 min" "+%d/%b/%Y:%H:%M") -e $(date --date="-4 min" "+%d/%b/%Y:%H:%M") -e $(date --date="-3 min" "+%d/%b/%Y:%H:%M") -e $(date --date="-2 min" "+%d/%b/%Y:%H:%M") -e $(date --date="-1 min" "+%d/%b/%Y:%H:%M") -e $(date "+%d/%b/%Y:%H:%M") /var/log/nginx/*.log | awk '{ print $1 }' | egrep -v '/var/log/nginx/access.log' | sort | uniq -c | sort -nr | sed 's|/var/log/nginx/||g' | head -25
```


#### This is a grep command to get the lastest "5 user-agent" from the latest "25 lines" in the log access from the server with nginx as a webserver ('egrep -v' non-matching or better saying, excluding "Pingdom.com").
```
grep -e $(date --date="-5 min" "+%d/%b/%Y:%H:%M") -e $(date --date="-4 min" "+%d/%b/%Y:%H:%M") -e $(date --date="-3 min" "+%d/%b/%Y:%H:%M") -e $(date --date="-2 min" "+%d/%b/%Y:%H:%M") -e $(date --date="-1 min" "+%d/%b/%Y:%H:%M") -e $(date "+%d/%b/%Y:%H:%M") /var/log/nginx/*.log | awk -F'\"' '/GET/ {print $6}' | egrep -v '/var/log/nginx/access.log' | egrep -v 'Pingdom.com' | sort | uniq -c | sort -nr | sed 's|/var/log/nginx/||g' | head -25
```
