# Operational Notes

## Wifi

Delete existing connection before reconnecting:
```shell
nmcli connection delete <SSID>
nmcli device wifi connect <SSID> password <password>
```

## Audio (PipeWire / wpctl)

List sinks and find the ID:
```shell
wpctl status
```

Set default sink:
```shell
wpctl set-default <ID>
```

Adjust microphone volume:
```shell
wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%+
wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%-
```

## Chinese input (fcitx5)

fcitx5 is autostarted by Sway. To reconfigure:
```shell
fcitx5-configtool
```

## SOPS secrets

Get the age public key:
```shell
nix-shell -p age --run 'age-keygen -y ~/.config/sops/age/keys.txt'
```

Create or edit secrets:
```shell
nix-shell -p sops --run 'sops secrets/secrets.yaml'
```

## X server display (xrandr)

List displays:
```shell
xrandr
```

Turn a display off/on:
```shell
xrandr --output <display-id> --off
xrandr --output <display-id> --auto
```

## Manual post-install steps

- Copy desired wallpaper to `$HOME/.wallpaper` (home-manager symlinks can't be read by hyprpaper).
- Import GPG keys.
- Configure Brave extensions (Dark Reader, Vimium).
