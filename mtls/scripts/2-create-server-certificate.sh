#/bin/sh

# SERVER: GENERATE SERVER ASSYMMETRIC PRIVATE KEY
#   - Private key for decrypting
openssl genrsa \
  -out server.key 2048

# SERVER: GENERATE CERTIFICATE SIGNING REQUEST
openssl req \
  -new \
  -key server.key \
  -subj '/CN=localhost' \
  -out server.csr

# CA: Create and sign certifificate
#   - With CA private key
#   - With server CSR
openssl x509 \
  -req \
  -in server.csr \
  -CA ca.crt \
  -CAkey ca.key \
  -CAcreateserial \
  -days 365 \
  -out server.crt

# ALL: Inspect server certificate
#    - Issuer is my-ca
#    - Subject = localhost
#    - Contains server public key
#    This indicates that this certificate can be served to a client to validate 
#    that the server is trusted to serve up content for the DNS name localhost
openssl x509 \
  -in server.crt \
  -text \
  -noout