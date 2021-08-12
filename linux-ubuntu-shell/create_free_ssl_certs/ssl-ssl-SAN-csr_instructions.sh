#Create a "ssladmin" user message (after the user is already  created)
$ cat ~/.ssladmin_profile
# ~/.ssladmin_profile: executed by the command interpreter for login shells.
# this file read by .bashrc

cd ~/
echo -e 'Hello admin!\n
**************************************************************
*                       Pay attention!                       *
*                                                            *
* The user "ssladmin" is a special user to manage SSL-CERTs, *
* run carefully the commands to manage the certificates!     *
**************************************************************
'

# ==========================================
$ cat "~/.bashrc"
...
# custom commands when log as ssladmin user on "~/.bashrc" file
if [ -f ~/.ssladmin_profile ]; then
    . ~/.ssladmin_profile
fi

# =================== Test the new user :message"  =======================
sudo su ssladmin
cd ~/csr

mkdir www.example.com
cd www.example.com

# ================  Create a  ssl-csr and ssl-key  ================================
# for a WILDCARD domain, use 'star.example.com.key' and 'www.example.com.csr'
# Add -subj '/CN=localhost' to suppress questions about the contents of the certificate (replace localhost with your desired domain).
openssl req -new -newkey rsa:2048 -nodes -keyout  star.example.com.key -out  star.example.com.csr

# for a SINGLE domain, use 'www.example.com.key' and 'www.example.com.csr'
openssl req -new -newkey rsa:2048 -nodes -keyout  www.example.com.key -out  www.example.com.csr

# BELLOW IS THE OUTPUT FORM THE ABOVE CMD

writing new private key to 'www.example.com.key'
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:GB
State or Province Name (full name) [Some-State]:England
Locality Name (eg, city) []:London
Organization Name (eg, company) [Internet Widgits Pty Ltd]:Company web services Ltd
Organizational Unit Name (eg, section) []:IT
Common Name (e.g. server FQDN or YOUR name) []:www.example.com # for wildcard uses '*.example.com' not 'www.example.com'
Email Address []:

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:
An optional company name []:


# ================  Create a  ssl-csr and ssl-key IN ONE COMMAND AUTOMATION VERSION ================================
#Create key and csr for the web-address, e.g `dev.localhost`

`openssl req -new -sha256 -key www.example.com.key \
    -subj "/C=GB/ST=England/L=London/O=Local organization Ltd/OU=IT/CN=*.example.com" \
    -reqexts SAN \
    -config <(cat /etc/ssl/openssl.cnf \
        <(printf "\n[SAN]\nsubjectAltName=DNS:example.com,DNS:www.example.com")) \
    -out example.com.csr`


# After this section an key and csr will be generated
# ================================================
# to validate the ssl with the websote via DNS, after that check it with 'did @8.8.8.8' CMD
# [ _C88B9E4CE999676E8BB6F21E43AF181F.example.com ---> ABC123.123ABC.AAA111BBB222.comodoca.com ]

# Test the DNS record and check the details of where the DNS is poiting
dig @8.8.8.8 _C88B9E4CE999676E8BB6F21E43AF181F.example.com

# ================================================

Wait for the "www.thesslstore.com" be verified and download the ssl-certs

# new bundle-chain and ocsp.crt
cat My_CA_Bundle.ca-bundle USERTrustRSAAAACA.crt AAACertificateServices.crt | sudo tee -a www_example_com.ca-bundle
cat www_example_com.crt SectigoRSADomainValidationSecureServerCA.crt USERTrustRSAAAACA.crt AAACertificateServices.crt | sudo tee -a www_example_com.sha256.crt-ocsp.chain.crt


# generate the dhparam.pem (take 100 CPU and a long time, considere to run it on a powerful ec2 to get this done quickly )
sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 4096

# To test the ssl certs after implemented in the website
https://www.ssllabs.com/ssltest/analyze.html

# TEST OCSP
echo QUIT | openssl s_client -connect www.digitalocean.com:443 -status 2> /dev/null | grep -A 17 'OCSP response:' | grep -B 17 'Next Update'

# Check the expiration date
echo | openssl s_client -showcerts -servername gnupg.org -connect gnupg.org:443 2>/dev/null | openssl x509 -inform pem -noout -text


# ==================== Verification ============================
# Verify the CSR and print CSR data filled in when generating the CSR:
openssl req -text -noout -verify -in www.example.com.csr
# Check the SSL key and verify the consistency:
openssl rsa -in www.example.com.key -check
# Check a certificate and return information about it (signing authority, expiration date, etc.):
openssl x509 -in www.example.com.crt -text -noout
# check if your CSR contains the right commonName (CN) or DNS for SAN-SSL-CERTS
openssl req -noout -text -in www.example.com.csr | grep -E 'CN|DNS'


# ====================  Verify that certificate and key matches ============================
# These two commands print out md5 checksums of the certificate and key; the checksums can be compared to verify that the certificate and key match.
openssl x509 -noout -modulus -in www_example_com.crt | openssl md5
openssl rsa -noout -modulus -in www_example_com.key | openssl md5


# ==================== Track the CERTS ============================
1 - root (the crt itself)
2 - rsa
3 - trust-rsa
4 - ca (certificate root authority)

openssl x509 -in www_example_com.crt -text -noout  | egrep 'Issuer:|Subject:'
openssl x509 -in SectigoRSADomainValidationSecureServerCA.crt -text -noout | egrep 'Issuer:|Subject:'
openssl x509 -in USERTrustRSAAddTrustCA.crt -text -noout | egrep 'Issuer:|Subject:'
openssl x509 -in AddTrustExternalCARoot.crt -text -noout | egrep 'Issuer:|Subject:'

www_example_com.crt
      | --> SectigoRSADomainValidationSecureServerCA.crt
                      | --> USERTrustRSAAddTrustCA.crt
                                      |--> AddTrustExternalCARoot.crt
                                     
##########  // ###################  // ######################
# 1) SAN SSL-CERT  =============================
# How to Create a CSR and Key File for a SAN Certificate with Multiple Subject Alternate Names
# Example can be seem here (cat /etc/ssl/openssl.cnf)

# 1.Create an OpenSSL configuration file (text file) on the local computer by editing the fields to the company requirements.
# https://support.citrix.com/article/CTX227983

# 2) create a file "san_ssl_cert_alt_names.cnf" =============================
[ req ]
distinguished_name = req_distinguished_name
default_bits	 = 2048
default_keyfile 	 = privkey.pem
attributes		 = req_attributes
x509_extensions	 = v3_ca	# The extentions to add to the self signed cert
req_extensions     = v3_req   # The extensions to add to a certificate request
prompt             = no

[ req_distinguished_name ]
C = UK                # countryName         = Country Name (2 letter code)
ST = England          # stateOrProvinceName = State or Province Name (full name)
L = London            # localityName        = Locality Name (eg, city)
O = MyCompany Ltd     # organizationName    = Organization Name (eg, company)
OU = IT department    # organizationUnit    = Organizational Unit Name (eg, section - Informatic, It, Media, ect)
CN = www.example.com  # commonName          = Common Name (e.g. server FQDN or YOUR name)

[ req_attributes ]
# challengePassword	= A challenge password
# challengePassword_min	=
# challengePassword_max	= 20
# unstructuredName	= An optional company name

[ v3_ca ] # Extensions for a typical CA
# PKIX recommendation.
subjectKeyIdentifier=hash
authorityKeyIdentifier=keyid:always,issuer

# This is what PKIX recommends but some broken software chokes on critical
# extensions.
#basicConstraints = critical,CA:true
# So we do this instead.
basicConstraints = CA:true

# Key usage: this is typical for a CA certificate. However since it will
# prevent it being used as an test self-signed certificate it is best
# left out by default.
# keyUsage = cRLSign, keyCertSign

# Some might want this also
# nsCertType = sslCA, emailCA

# Include email address in subject alt name: another PKIX recommendation
# subjectAltName=email:copy
# Copy issuer details
# issuerAltName=issuer:copy

# DER hex encoding of an extension: beware experts only!
# obj=DER:02:03
# Where 'obj' is a standard or added object
# You can even override a supported extension:
# basicConstraints= critical, DER:30:03:01:01:FF

[ v3_req ] # Extensions to add to a certificate request
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
subjectAltName=@alt_names

[ alt_names ]
DNS.1 = www.example.com
DNS.2 = example.com
DNS.3 = www.example.net
DNS.4 = example.net
DNS.5 = example.it
DNS.6 = example.co.uk

# 3) Generate KEY and CSR with the alternative DNS names for SAN  =============================
openssl req -new -newkey rsa:2048 -nodes -keyout www.example.com.key -out www.example.com.csr -config san_ssl_cert_alt_names.cnf

# check if your CSR contains the right commonName (CN) or DNS for SAN-SSL-CERTS
openssl req -noout -text -in www.example.com.csr | grep -E 'CN|DNS'

