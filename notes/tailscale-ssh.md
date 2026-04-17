# SSH into Laptop from Termux via Tailscale

## First-time Tailscale setup (laptop)

After running `nixos-rebuild switch` on the framework machine, authenticate to your Tailscale account:

```shell
sudo tailscale up
```

A URL will be printed — open it in a browser to log in. Once authenticated, confirm the interface is up and note your Tailscale IP:

```shell
ip addr show tailscale0
```

The address will be in the `100.x.x.x` range.

## First-time Tailscale setup (phone)

Install the Tailscale app from the Play Store, sign in with the same account, and toggle it on. Both devices must be on the same tailnet for the tunnel to form.

Verify both devices are visible to each other:

```shell
sudo tailscale status
```

You should see both the laptop and phone listed, e.g.:
```
100.68.33.5  framework  asungy@  linux   -
100.x.x.x    phone      asungy@  android -
```

If only the laptop appears, the phone isn't connected yet.

## First-time SSH key setup (Termux)

Generate a key pair on your phone if you don't have one:

```shell
pkg install openssh
ssh-keygen -t ed25519 -C "termux@phone"
cat ~/.ssh/id_ed25519.pub
```

Copy the output and add it to `system/modules/user.nix` in the loadout repo:

```nix
openssh.authorizedKeys.keys = [
  "ssh-ed25519 AAAA... termux@phone"
];
```

Then rebuild and switch on the framework machine.

## Connecting from Termux

```shell
ssh asungy@<tailscale-ip>
```

To avoid typing the IP every time, add an entry to `~/.ssh/config` in Termux:

```
Host framework
    HostName 100.x.x.x
    User asungy
    IdentityFile ~/.ssh/id_ed25519
```

Then connect with just:

```shell
ssh framework
```

## Troubleshooting

Check that Tailscale is running on the laptop:
```shell
sudo tailscale status
```

Check that sshd is running:
```shell
systemctl status sshd
```

If `tailscale status` shows the laptop as offline, re-authenticate:
```shell
sudo tailscale up
```
