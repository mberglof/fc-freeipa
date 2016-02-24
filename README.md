# freeipa

Wrapper cookbook to setup FreeIPA @ FC

This cookbook allow you to install FreeIPA client and server.

The server install doesn't need any extra configuration to work. It also checks that
if the server is already installed, then no further action is taken so there is no 
risk of override the configuration file.

To make the client install work, after run the recipe you need to log into the machine,
and run:
```
ipa-client-install --domain=domain --server=server --force-ntpd --mkhomedir -p userwithprivileges
```

i.e.
```
ipa-client-install --domain=fundingcircle.co.uk --server=server.fundingcircle.co.uk --force-ntpd --mkhomedir -p ggahete

```