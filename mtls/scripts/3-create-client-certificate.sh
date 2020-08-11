#/bin/sh

# CLIENT: GENERATE CLIENT ASSYMMETRIC KEYS
openssl genrsa \
  -out client.key 2048

# CLIENT: Creating the CSR with the arbitrary Common Name of my-client
openssl req \
  -new \
  -key client.key \
  -subj '/CN=my-client' \
  -out client.csr

# CA: Creating the client certificate
openssl x509 \
  -req \
  -in client.csr \
  -CA ca.crt \
  -CAkey ca.key \
  -CAcreateserial \
  -days 365 \
  -out client.crt