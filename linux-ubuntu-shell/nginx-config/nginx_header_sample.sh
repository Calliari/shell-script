# NOTES on how to show the origin IP address (clinet IP)

https://blog.jayway.com/2014/03/28/how-to-get-the-client-ip-when-using-cloudfront-and-nginx/

# Possible nginx headers 

add_header nginx_scheme "$scheme";
add_header X-uri "$uri";
add_header http-origin "$http_origin";
add_header remote-ip "$remote_addr";
add_header host-name-websie "$host";
add_header request-uri "$request_uri";
add_header server-addr "$server_addr";
add_header server-port $server_port;
add_header server-name "$server_name";
add_header real_ip_remote-addr "$realip_remote_addr";
add_header ihostname "$hostname";
add_header arg-test "$is_args";
add_header args-test1 "$args";
add_header args-nocache "$arg_nocache";
add_header arg-comment "$arg_comment";
add_header link-l "$request_length";
add_header root-l "$document_root";
add_header doc-l "$document_uri";
add_header path "$realpath_root";
add_header link "$upstream_http_";
add_header http_host "$http_host";
add_header origin_ip "$http_x_real_ip";
add_header http_pragma "$http_pragma";
add_header http_x_forwarded_for "$http_x_forwarded_for";
add_header http_x_forwarded_user "$http_x_forwarded_user";
add_header http_x_upstream_status" $upstream_status";
add_header connection_number" $connection";
add_header http_authorization "$http_authorization";
add_header args_nocache "$arg_nocache";
add_header cookie_nocache "$cookie_nocache";
add_header http_upgrade "$http_upgrade";
add_header fastcgi_script_name "$fastcgi_script_name";
add_header remote_user "$remote_user";
==========================================================================================

# Ignore trusted IPs
real_ip_recursive on;

# Set CloudFront subnets as trusted
set_real_ip_from 127.0.0.1;
set_real_ip_from 54.182.243.0/28;
set_real_ip_from 54.192.0.0/16;
set_real_ip_from 54.230.0.0/16;
set_real_ip_from 54.239.128.0/18;
set_real_ip_from 54.239.192.0/19;
set_real_ip_from 54.240.128.0/18;
set_real_ip_from 204.246.164.0/22;
set_real_ip_from 204.246.168.0/22;
set_real_ip_from 204.246.174.0/23;
set_real_ip_from 204.246.176.0/20;
set_real_ip_from 205.251.192.0/19;
set_real_ip_from 205.251.249.0/24;
set_real_ip_from 205.251.250.0/23;
set_real_ip_from 205.251.252.0/23;
set_real_ip_from 205.251.254.0/24;
set_real_ip_from 216.137.32.0/19;

==========================================================================================
# Creating a custom log to show all ips on logs access file, good for dDos attacks, get IP and block them all
log_format custom_log '$http_x_forwarded_for - $remote_addr - $remote_user [$time_local] '
                      '"$request" $status $body_bytes_sent '
                      '"$http_referer" "$http_user_agent"'
                      '$geoip_country_name $geoip_country_code '
                      '$geoip_region_name $geoip_city ';

access_log /var/log/nginx/access.log custom_log;


==========================================================================================
# Get the most top IPs which are flooding the server with requests based on latest 1500 logs' lines
# get filter specific path, and sort on reverse order to make mosts frequent to be on top and limit it for 20 entries only
tail -15000 access.log | grep -E 'wp-login.php|xmlrpc|index.php|index.html|login' | awk '{ print $1 }' | sort | uniq -c | sort -nr | head -20

# get filter specific request, and sort on reverse order to make mosts frequent to be on top
cat access.log | grep 'HTTP/1.1' | awk '{ print $1 }' | sed 's/"//g' | sort | uniq -c | sort -nr

==========================================================================================
Testing response headers

#target is 'www.sample.com'
curl -i -X POST https://www.sample.com/test
curl -I -X POST https://www.sample.com/test

#  Origin is 'http://127.0.0.1:3000' - target is 'https://the.sign_in.url'
curl -i -X OPTIONS -H "Origin: http://127.0.0.1:3000" -H 'Access-Control-Request-Method: POST' -H 'Access-Control-Request-Headers: Content-Type, Authorization' "https://the.sign_in.url"

#  Origin is 'https://www.example.com' - target is 'https://www.sample.com'
curl -i -X OPTIONS -H "Origin: www.example.com"  -H 'Access-Control-Request-Headers: Content-Type, Authorization' "https:///www.sample.com"
curl -i -X OPTIONS "https://www.sample.com" -H 'Access-Control-Request-Method: POST' -H 'Access-Control-Request-Headers: Content-Type, Accept' -H 'Origin: https://www.example.com'

#  Origin is 'https://www.example.com' - target is 'https://www.sample.com'
curl -s -D - -H "Origin: https://www.example.com"  "https:///www.sample.com"
curl -s -D - -H "Origin: https://www.example.com"-X OPTIONS "https:///www.sample.com"

