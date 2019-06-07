# make sure you can use a toll call "htpasswd", if not install this tool


#### generate a file with a user and password 

##### press enter, and then type the password twice to confirm
```
htpasswd -c /tmp/example.com-auth.pwd user1 
```

#### The tool will generate a file on path specified "/tmp/example.pwd" with a username "user1" with a password chosen.


####To combine this with nginx add an in include file on nginx file such as:

```
include /tmp/example.com-auth.conf;
```

The content of a file `/tmp/example.com-auth.conf` need to have a path to password and a few rules, suach as:

```
satisfy any;
allow FROM RANGE OF IPs ADDRESS;
auth_basic "Restricted";
auth_basic_user_file /tmp/example.com-conf.pwd;
```
