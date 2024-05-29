# Setting up NordVPN

NordVPN isn't fully supported so some manual work is required.

1. Grab an access token from the NordVPN dashboard.
2. Login using `sudo wgnord login <access token>`
3. Copy the following text to `/var/lib/wgnord/template.conf`:
```
[Interface]
PrivateKey = PRIVKEY
Address = 10.5.0.2/32
MTU = 1350
DNS = 103.86.96.100 103.86.99.100

[Peer]
PublicKey = SERVER_PUBKEY
AllowedIPs = 0.0.0.0/0, ::/0
Endpoint = SERVER_IP:51820
PersistentKeepalive = 25
```
4. Test connection: `sudo wgnord connect france`
