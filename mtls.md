# Overview
- [Overview](#overview)
- [Public key cryptography](#public-key-cryptography)
  - [First step: asymmetric encryption](#first-step-asymmetric-encryption)
  - [Second step: symmetric key](#second-step-symmetric-key)
- [Problem: unauthorized server -> man in the middle attack](#problem-unauthorized-server---man-in-the-middle-attack)
  - [Solution](#solution)
- [Problem: unauthorized client](#problem-unauthorized-client)
- [Notes](#notes)
- [Questions](#questions)
- [Private key](#private-key)
- [Articles](#articles)
  

# Public key cryptography
- Public key which contains the reference to encode the data
- Private key, which contains the reference to decode the data

## First step: asymmetric encryption 
<p align="center"><img height=200 src="images/15c07fcc1dfb3b947221cf8f7367fea58a8cd71685929b3dff9c5f5e819e4342.png"/></p>
- Private data from client to server

## Second step: symmetric key
![picture 5](images/c7f7c12b57ef79c6d6db7d4ea5b2197df9986552a6688f87dbc82f5c9c193bbe.png)  
- Private data between client and server
- Client sends key to encrypt/decrypt data

# Problem: unauthorized server -> man in the middle attack
![picture 6](images/15f3c7537d9100931814c29a03b53844674649adf32af1435f044360a1135e59.png)  

## Solution
- Client asks public key and certificate
- Validates with certificate authority if certificate is legit
![picture 7](images/87447412bbf3edbaf91505dd8a0b9cb03f94fdf07f34de9af03a0930a490aa4f.png)  

# Problem: unauthorized client
![picture 8](images/ef5b5fdb0ef9c8d237b8cd418697ad185132d8383dac191f312956efb9a45d53.png)  
- Server validates with certificate authority that client cert is valid
- Client sends its own certificate and symmetric key

![picture 3](images/63a709643667d065af476b222a3f834f2010794c5bf8681afde00a2d86e563ed.png)  

# Notes
- Ensures that traffic is both secure and trusted in both directions between a client and server
- Allows requests that do not log in with an identity provider (like IoT devices) to demonstrate that they can reach a given resource

# Questions
- How validation?

# Private key
- Validation
- Compressing

# Articles
- https://developers.cloudflare.com/access/service-auth/mtls/
- https://medium.com/sitewards/the-magic-of-tls-x509-and-mutual-authentication-explained-b2162dec4401