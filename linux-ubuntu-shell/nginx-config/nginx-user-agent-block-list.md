https://www.xmodulo.com/block-specific-user-agents-nginx-web-server.html#google_vignette


##### These if statements match any bad "user-agent" string with regular expressions, 
and return 403 HTTP status code when a match is found. 
- ($http_user_agent) is a variable that contains the user-agent string of an HTTP request. 
- (~)  is an operator does case-sensitive matching against user-agent string, 
- (~*) is an operator does case-insensitive matching. 
- (|)  is an operator is logical-OR, so you can put as many user-agent keywords in the if statements, and block them all.

```
server {
    listen       80 default_server;
    server_name  xmodulo.com;
    root         /usr/share/nginx/html;

    # case sensitive matching
    if ($http_user_agent ~ (Antivirx|Arian)) {
        return 403;
    }

    # case insensitive matching
    if ($http_user_agent ~* (netcrawl|npbot|malicious)) {
        return 403;
    }

    ....
}
```

OR 

##### Create a file and add all the bad user-agent as a list, using nbinx key world "map":
```
#sudo vi /etc/nginx/useragent.rules
```
Add the list to a file:
```
map $http_user_agent $badagent {
        default         0;
        ~*malicious     1;
        ~*backdoor      1;
        ~*netcrawler    1;
        ~Antivirx       1;
        ~Arian          1;
        ~webbandit      1;
}

```

Add the file as include in the nginx "http" block configuration part:
```
http {
    .....
    include /etc/nginx/useragent.rules
}
```

Add the configuration in the server block: 
```
server {
    ....
    if ($badagent) {
        return 403;
    }
    ....
}
```

reload nginx.
```
$ sudo /path/to/nginx -s reload
```


Testing user-agent blockedg by using wget or curl with --user-agent option.
```
$> wget --user-agent "malicious bot" http://<nginx-ip-address>
```


