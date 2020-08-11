#!/bin/sh

# ca.crt is needed to validate server certificate
# client.crt is needed to send to server to encrypt data
# client.key is needed to decrypt server data

curl \
  --cacert ca.crt \
  --key client.key \
  --cert client.crt \
  https://localhost:3000