# Securing Cisco AnyConnect Client Script with CyberArk Credential Provider

This repo contains sample scripts for AnyConnect VPN Client without embedding secrets.
The secrets used will be fetched by CyberArk Credential Providers.

## Scripts

- connect_vpn1.cmd (connect VPN with _vpn1.cmd)
- _vpn1.cmd (call CyberArk CP SDK, login to VPN)
- disconnect.cmd (disconnect VPN)
- state.cmd (get state of VPN)
- generateHash.cmd (generates Hash value for CP hash authn)


## Maintainer
Quincy Cheng
