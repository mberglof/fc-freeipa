# freeipa

Wrapper cookbook to setup FreeIPA @ FC

This cookbook allow you to install FreeIPA client and server.

The server install doesn't need any extra configuration to work. It also checks that
if the server is already installed, then no further action is taken so there is no 
risk of override the configuration file. Server is also configured in the same way.
