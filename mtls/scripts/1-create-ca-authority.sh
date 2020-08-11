#/bin/sh

openssl req \
  -new \
  -x509 \
  -nodes \
  -days 365 \
  -subj '/CN=my-ca' \
  -keyout ca.key \
  -out ca.crt