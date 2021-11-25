# make sure we have don these steps
sudo apt update -y
sudo apt install -y nginx

# For the domain-name, the DNS needs to resolve public i.e 'make sure it poings to a server available publicly' - "example.com"
I.G:

# $ dig @8.8.8.8 example.com
# ...
# ;; ANSWER SECTION:
# example.com. 60 IN	A	3.10.1.12


# Now let's create the tls for the dmoain
# https://certbot.eff.org/instructions?ws=nginx&os=ubuntu-18
sudo snap install core; sudo snap refresh core
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
sudo certbot --nginx
