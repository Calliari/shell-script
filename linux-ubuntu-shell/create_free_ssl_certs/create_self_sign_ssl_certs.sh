# Generating RSA private key, 2048 bit long modulus
openssl genrsa -out key.pem 2048

# Create a sign certificate request 'CSR' based on the private key 'key.pem'
# add 'XX' for 'Country Name' in case it's for a prod env fill out all the sections
openssl req -new -sha256 -key key.pem -out csr.csr # (Manual) 
openssl req -new -sha256 -key key.pem -out csr.csr # (automatic) 



# Generate the certificate to encrypt connections
openssl req -x509 -sha256 -days 365 -key key.pem -in csr.csr -out certificate.pem
