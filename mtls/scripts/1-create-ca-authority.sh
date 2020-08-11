#/bin/sh

# CA MACHINE: CREATE CA AUTHORITY
#   The first step is to create a certificate authority (CA) that both the client and server trust.
#   Returns
#   - CA private key: used to sign
#   - CA certificate: used to validate (CA certificate is always self signed)
openssl req \
  -new \
  -x509 \
  -nodes \
  -days 365 \
  -subj '/CN=my-ca' \
  -keyout ca.key \
  -out ca.crt

# ALL: INSPECT CA CERTIFICATE
#    Everybody can do it
openssl x509 \
  -in ca.crt \
  -text \
  -noout

