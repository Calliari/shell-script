# Generating RSA private key, 2048 bit long modulus
openssl genrsa -out key.pem 2048

# Create a sign certificate request 'CSR' based on the private key 'key.pem'
# add 'XX' for 'Country Name' in case it's for a prod env fill out all the sections

# (Manual) 
openssl req -new -sha256 -key key.pem -out csr.csr 

# Generate the certificate to encrypt connections
openssl req -x509 -sha256 -days 365 -key key.pem -in csr.csr -out certificate.pem

######################## ############# #################
# This is an example with 'www.example.com.key' domain

openssl genrsa -out www.example.com.key 2048

# (automated with 'www.example.com.key' and 'example.com.csr' )
openssl req -new -sha256 -key www.example.com.key \
    -subj "/C=GB/ST=England/L=London/O=Local organization Ltd/OU=IT/CN=*.example.com" \
    -reqexts SAN \
    -config <(cat /etc/ssl/openssl.cnf \
        <(printf "\n[SAN]\nsubjectAltName=DNS:example.com,DNS:www.example.com")) \
    -out example.com.csr
    
openssl req -x509 -sha256 -days 365 -key www.example.com.key -in example.com.csr -out www.example.com.crt


