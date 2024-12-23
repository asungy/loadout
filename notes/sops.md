> The way I use sops is kind of a pain. Still looking for better solutions....

# Get the public key

```shell
nix-shell -p age --run 'age-keygen -y ~/.config/sops/age/keys.txt'
```

# Create/Edit secrets

```shell
nix-shell -p sops --run 'sops secrets/secrets.yaml'
```

https://linuxcommandlibrary.com/man/sops
