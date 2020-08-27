# Mutual TLS <!-- omit in toc -->
This document will give an overview of all the insights that I have about (mutual) TLS.  

- [Use cases](#use-cases)
- [Types of keys](#types-of-keys)
- [Scenarios for assymmetric keys](#scenarios-for-assymmetric-keys)
- [Certificate](#certificate)
- [Certificate Authority](#certificate-authority)
- [Certificate chain](#certificate-chain)
- [mTLS](#mtls)
- [Articles](#articles)

## Use cases
When sending a message between two parties you have two problems that you need to address.
|Problem|Solution |
|-|-|
|How do you know that the party is correct?|Certificate signing|
|How do you know that no one has read the message?|Data encryption|

- The ultimate link is to send and receive data via the public key of the certificate, to see if the other party reacts on it.
- The certificate contains the public key

## Types of keys
The following types of cryptomatic keys are
- Assymmetric -> One party can read other party can write
- Symmetric -> Client / server can read and write data (faster)

## Scenarios for assymmetric keys
There are two scenarios for using assymmetric keys:
- Signing: *One sign, Many validates*
  - Server signs a document with private key
  - Client uses servers public available public key to decrypt document
  - Other servers cannot sign documents
- Encrypting: *Many encode, One decode*
  - Client uses public key to encode
  - Server uses private key to decode
  - Other clients cannot read data

## Certificate
- A digital certificate provides a link between a public key and an entity (business,domain name etc) that has been verified (signed) by a trusted third party ( A certificate authority)
- Just like a passport established a link between a photo and a person, and that link has been verified by a trusted authority (passport office).

## Certificate Authority
The responsibilities of a certificate authorityes are:
- Acts to validate the identities of entities
- Bind them to cryptographic keys through the issuance of electronic documents known as digital certificates

## Certificate chain
- Intermediate certificates has to be sent to client
- The root ca is installed on machine or in browser
- The browser will validate the signature with the public key of the higher certificate
- <img height=200 src="../images/f3771aeaf10f0448db112ecb5081971feee3dec73ae89ab16af696896f9ea3c3.png"/>

###### Process
The process of obtaining a signed certificate:
1. Workstation sends a Certificate Signing request and public key
1. Private key is always kept private
1. CA signs a certificate with own private key
1. Third party can cryptographically confirm the CA's signature via the CA's public key (available in browsers)
1. <img height=200 src="../images/7a76d6af0ac8410d2e63e46f2bcaafcd8eed865e8bce531c81869469b83d6cdd.png"/>

## mTLS
- Ensures that traffic is both secure and trusted in both directions between a client and server
- Allows requests that do not log in with an identity provider (like IoT devices) to demonstrate that they can reach a given resource
- mTLS: Mostly used for b2b > operational burden is limited, and security requirements are usually much higher
- TLS: Mostly used for customer facing environments

###### First step: asymmetric encryption 
- Private data from client to server
- <img height=200 src="../images/15c07fcc1dfb3b947221cf8f7367fea58a8cd71685929b3dff9c5f5e819e4342.png"/>

###### Second step: symmetric key
- Private data between client and server
- Client sends key to encrypt/decrypt data
- <img height=200 src="../images/c7f7c12b57ef79c6d6db7d4ea5b2197df9986552a6688f87dbc82f5c9c193bbe.png"/>

###### Problem: unauthorized server -> man in the middle attack
- <img height=200 src="../images/15f3c7537d9100931814c29a03b53844674649adf32af1435f044360a1135e59.png"/>

###### Solution
- Client asks public key and certificate
- Validates with certificate authority if certificate is legit
- <img height=200 src="../images/87447412bbf3edbaf91505dd8a0b9cb03f94fdf07f34de9af03a0930a490aa4f.png"/>

###### Problem: unauthorized client
- Server validates with certificate authority that client cert is valid
- Client sends its own certificate and symmetric key
- 
- <img height=200 src="../images/ef5b5fdb0ef9c8d237b8cd418697ad185132d8383dac191f312956efb9a45d53.png"/>

## Articles
- https://developers.cloudflare.com/access/service-auth/mtls/
- https://medium.com/sitewards/the-magic-of-tls-x509-and-mutual-authentication-explained-b2162dec4401
- https://codeburst.io/mutual-tls-authentication-mtls-de-mystified-11fa2a52e9cf
- https://security.stackexchange.com/questions/56389/ssl-certificate-framework-101-how-does-the-browser-actually-verify-the-validity
- http://www.steves-internet-guide.com/ssl-certificates-explained/
- https://www.youtube.com/watch?v=ohn89zOcf4M
