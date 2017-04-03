# oauth2-implicit-flow


There are 2 applications showing OAuth2 implicit flow. One is using a popup written in Javascript (communication via ports). The other one is without popup, just plain redirect and URL monitoring.

After successful login access token is stored in the local storage

Notice: I don't handle expired tokens in this app but this should be trivial to implement.

Read more about OAuth2 Implicit Flow [here](https://tools.ietf.org/html/rfc6749#section-4.2)


## How to start

Move to a sub directory and from there just:

1. `yarn` - this will install all dependencies
2. `yarn start` - this will run the application in developer mode
