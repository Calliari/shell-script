# Testing request

# send a request to the nginx sevrer with HOSTNAME from using the localhost
curl --verbose --header 'Host: HOSTNAME WHERE THE NGINX IS CONFIGURED' -k 'https://127.0.0.1:8201'

# Check connectivity resolving the FQDN on the localhost with the port configured on the nginx webserver
curl -v --resolve example.com:1002:127.0.0.1  https://example.com:1002

# Testing with the client certs to the endpoinht (http or https)
curl --cacert ./ca.crt \. # The CA certificate belonging to the CA that signed the server's certificate (if it is not already included with your OS trusted certs)
     --key ./client.key \ # Your client certificate
     --cert ./client.crt \ # Your client private key
     https:[EXAMPLE_URL]


# Testing with the client certs to the endpoinht (http or https) using the localhost
curl -v --cert ./certificate.crt --key ./key-certificate.key --header 'Host: example.com'  http://127.0.0.1:443
curl -v --cert ./certificate.crt --key ./key-certificate.key --cacert cert-authority-certificate.crt --header 'Host: example.com'  http://127.0.0.1:443


# Testing with the client certs to the endpoinht (http or https) using the localhost POST request with credentials
curl -vv --location --request POST 'example.com/token' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'grant_type=client_credentials' \
--data-urlencode 'client_id=CLIENT-ID' \
--data-urlencode 'client_secret=<CLIENT SECRET>'


# Testing with openssl
openssl s_client -connect localhost:443 -cert ./certificate.crt -key ./certificate-key.key -servername example.com 
GET / HTTP/1.0 
Host: example.com 

# check the certificate used by the "servername"
openssl s_client -connect localhost:443 -servername example.com   2>&1 | openssl x509 -text
