List channels:
```bash
> sudo nix-channel --list
nixos https://nixos.org/channels/nixos-<version>
```

Remove channel:
```bash
> sudo nix-channel --remove nixos
```

Add channel:
```bash
> sudo nix-channel --add nixos https://nixos.org/channels/nixos-unstable
```

Update the flake lockfile:
```bash
> sudo nix flake update
```
