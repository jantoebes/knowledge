# Overview <!-- omit in toc -->
- [Notes](#notes)
- [Public key cryptography](#public-key-cryptography)
- [First step: asymmetric encryption](#first-step-asymmetric-encryption)
- [Second step: symmetric key](#second-step-symmetric-key)
- [Problem: unauthorized server -> man in the middle attack](#problem-unauthorized-server---man-in-the-middle-attack)
- [Solution](#solution)
- [Problem: unauthorized client](#problem-unauthorized-client)
- [Questions](#questions)
- [Private key](#private-key)
- [Articles](#articles)
  


# Notes
- Ensures that traffic is both secure and trusted in both directions between a client and server
- Allows requests that do not log in with an identity provider (like IoT devices) to demonstrate that they can reach a given resource
- mTLS: Mostly used for b2b > operational burden is limited, and security requirements are usually much higher
- TLS: Mostly used for customer facing environments
  
# Public key cryptography
- Public key which contains the reference to encode the data
- Private key, which contains the reference to decode the data

# First step: asymmetric encryption 
- Private data from client to server
- <img height=200 src="../images/15c07fcc1dfb3b947221cf8f7367fea58a8cd71685929b3dff9c5f5e819e4342.png"/>

# Second step: symmetric key
- Private data between client and server
- Client sends key to encrypt/decrypt data
- <img height=200 src="../images/c7f7c12b57ef79c6d6db7d4ea5b2197df9986552a6688f87dbc82f5c9c193bbe.png"/>

# Problem: unauthorized server -> man in the middle attack
- <img height=200 src="../images/15f3c7537d9100931814c29a03b53844674649adf32af1435f044360a1135e59.png"/>

# Solution
- Client asks public key and certificate
- Validates with certificate authority if certificate is legit
- <img height=200 src="../images/87447412bbf3edbaf91505dd8a0b9cb03f94fdf07f34de9af03a0930a490aa4f.png"/>

# Problem: unauthorized client
- Server validates with certificate authority that client cert is valid
- Client sends its own certificate and symmetric key
- <img height=200 src="../images/ef5b5fdb0ef9c8d237b8cd418697ad185132d8383dac191f312956efb9a45d53.png"/>


# Questions
- How validation?

# Private key
- Validation
- Compressing

# Articles
- https://developers.cloudflare.com/access/service-auth/mtls/
- https://medium.com/sitewards/the-magic-of-tls-x509-and-mutual-authentication-explained-b2162dec4401
- https://codeburst.io/mutual-tls-authentication-mtls-de-mystified-11fa2a52e9cf