## Connect to Wifi

Make sure to delete existing connections:
```shell
nmcli connection delete <SSID>
```

Then reconnect using:
```shell
nmcli device wifi connect <SSID> password <password>
```
