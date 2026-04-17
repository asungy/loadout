# Architecture

## Flake outputs

`flake.nix` exposes four outputs:

| Output | Source | Purpose |
|--------|--------|---------|
| `homeConfigurations.asungy` | `outputs/home-conf.nix` | home-manager config for user `asungy` |
| `nixosConfigurations.{spytower,framework,kvm}` | `outputs/nixos-conf.nix` | per-machine NixOS system configs |
| `packages.x86_64-linux.x` | `x/default.nix` | the interactive CLI build tool |
| `devShells.x86_64-linux.default` | `devShell.nix` | dev shell with Rust + nixd |

Both nixpkgs imports set `allowUnfree = true`. The NixOS one also whitelists `ventoy`.

## Home-manager layer (`home/`)

`home/home.nix` is the single root module. It does two things:

1. **Imports program modules** — `builtins.concatMap import [./programs]` reads `home/programs/default.nix`, which is a plain list of subdirectory paths. Each subdirectory has its own `default.nix` that returns a home-manager module.

2. **Symlinks raw config files** — `home.file` maps `~/.config/<path>` to a source file under `home/config/`. This is used for tools that don't have a home-manager program option (sway, waybar, helix, ghostty, zellij, i3, etc.).

Current program modules: `alacritty`, `bash`, `fzf`, `git`, `starship`, `tmux`.

## NixOS layer (`system/`)

Each machine has two entry points composed in `outputs/nixos-conf.nix`:

```
system/machine/<name>/   ← hardware-configuration.nix (auto-generated, machine-specific)
system/<name>.nix        ← imports shared modules + sets system.stateVersion
```

`system/<name>.nix` selects which modules from `system/modules/` apply to that machine and sets `environment.systemPackages` from `system/packages.nix`.

Shared modules in `system/modules/`:

| Module | What it configures |
|--------|--------------------|
| `audio.nix` | PipeWire / WirePlumber |
| `environment_vars.nix` | System-wide env vars |
| `fonts.nix` | Font packages + fontconfig |
| `gpg.nix` | GPG agent / pinentry |
| `graphics/` | GPU drivers (AMD/Intel) |
| `i18n.nix` | Locale, fcitx5 Chinese input |
| `networking.nix` | NetworkManager + iwd + firewall |
| `nix_daemon.nix` | Nix daemon settings |
| `tablet.nix` | Drawing tablet udev/input |
| `udev/` | Custom udev rules |
| `user.nix` | User account + sudo |
| `virtualisation.nix` | Docker + QEMU/libvirt |
| `wayland.nix` | Sway session, XDG portals |

## The `x` CLI tool (`x/`)

A Rust binary built with `x/default.nix` and exposed as `packages.x`. It wraps the following raw commands behind an interactive `inquire` menu (vim-mode enabled):

- **Build home manager** → runs `home-manager switch --flake .#asungy`
- **Build system** → runs `sudo nixos-rebuild {switch|boot|test} --upgrade --flake .#<machine>`
- **Set wallpaper** → copies a selected wallpaper to `~/.wallpaper`
- **Set monitor** → configures display settings

The tool also contains logic to regenerate `hardware-configuration.nix` via `nixos-generate-config` and copy it into the appropriate `system/machine/<name>/` directory.

Source layout: `x/src/main.rs` → `prompt/mod.rs` dispatches to per-action modules; `core/` holds the underlying build logic.
