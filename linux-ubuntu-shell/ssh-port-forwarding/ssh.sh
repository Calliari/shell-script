

# Using this CMD, allows 
ssh -L 127.0.0.1:80:intra.example.com:80 gw.example.com


# connect to Linux using the Localhost GUI browser
E.X =  ssh -L {local-port}:{local-ip}:{remote-port} {server-alias}

# this connects to solr using the localhost browser
ssh -L 8984:127.0.0.1:8983 db_server_host

# Access the solr GUI connected to where the Solr is installed on server (db_lccc)
Open a browser and type
http://127.0.0.1:8984/solr/#/


Another solution to this is (Firefox: -> General -> Network Settings -> Manual proxy configuration: SOCKS Host:localhost, port:8080, select:SOCKS v5, select:Proxy DNS when using SOCKS v5)
ssh -D 8080 {server-alias/address}
Open the Firefox browser with the URL and it will work as it was on the server. 
