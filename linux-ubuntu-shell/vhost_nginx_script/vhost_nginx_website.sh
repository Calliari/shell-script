#!/bin/bash


sudo apt-get update -y
sudo apt-get install nginx -y

sudo mkdir -p /var/www/example.com/html
sudo mkdir -p /var/www/test.com/html

sudo chown -R $USER:$USER /var/www/example.com/html
sudo chown -R $USER:$USER /var/www/test.com/html

sudo chmod -R 755 /var/www

cat >> /var/www/example.com/html/index.html <<EOF
<html>
    <head>
        <title>Welcome to Example.com!</title>
    </head>
    <body>
        <h1>Success!  The example.com server block is working!</h1>
    </body>
</html>
EOF

cat >> /var/www/test.com/html/index.html <<EOF
<html>
    <head>
        <title>Welcome to Test.com!</title>
    </head>
    <body>
        <h1>Success!  The test.com server block is working!</h1>
    </body>
</html>
EOF

sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/example.com


 sudo tee /etc/nginx/sites-available/example.com <<'EOF'
server {
        listen 80;
        listen [::]:80;

        root /var/www/example.com/html;
        index index.html index.htm index.nginx-debian.html;

        server_name example.com www.example.com;

#        include /etc/nginx/example_auth.conf;

        location / {
                try_files $uri $uri/ =404;
        }
        
       location ~* /.well-known/validation/173.txt {
              alias /tmp/173.txt;
              allow all;
              default_type text/plain;
       } 
       
       location /hello {
          return 200 'hello, world!';
          allow all;
          default_type text/plain;
        }
}

EOF

sudo tee /etc/nginx/sites-available/test.com <<'EOF'
server {
        listen 80;
        listen [::]:80;

        root /var/www/test.com/html;
        index index.html index.htm index.nginx-debian.html;

        server_name test.com www.test.com;

        location / {
                try_files $uri $uri/ =404;
        }
}
EOF

sudo ln -s /etc/nginx/sites-available/example.com /etc/nginx/sites-enabled/
sudo ln -s /etc/nginx/sites-available/test.com /etc/nginx/sites-enabled/

sudo sed -i s/"# server_names_hash_bucket_size 64;"/"server_names_hash_bucket_size 64;"/g /etc/nginx/nginx.conf

sudo systemctl restart nginx

MY_IP=$(curl ifconfig.co)

echo -e "\n$MY_IP example.com www.example.com\n$MY_IP test.com www.test.com" | sudo tee -a /etc/hosts

exit
###########
# This will provide a secure pop up when you open a website
# create a file path: "/etc/nginx/example_auth.conf"
satisfy any;
auth_basic "Restricted";
auth_basic_user_file /etc/nginx/example_auth.pwd;

#create a username and pwd 
htpasswd -c /etc/nginx/common/example_auth.pwd username

# include the bellow line on your webhost nginx config
include /etc/nginx/example_auth.conf;



