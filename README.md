# verimi-login

This is the code specific for the Verimi login in our prototype. There are two folders, contaiining client and server code, respectively.

## Server

- Implements a controller to handle requests from our client and login users in Verimi.
- Implements a wrapper around the necessary Verimi API calls.

## Client

- Implements a service to redirect to Verimi login if it this option is selected.
- Implements a callback to the server once the authorization code has been successfully retrieved.
- Implements a service to handle Session with Verimi login
