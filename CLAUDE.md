# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal NixOS + home-manager configuration for user `asungy`, targeting three machines: **spytower** (desktop), **framework** (laptop), and **kvm** (virtual machine).

## Commands

```bash
# Apply home-manager or NixOS changes (interactive menu)
nix run .#x

# Enter dev shell (Rust toolchain, GCC, GDB, nixd)
nix develop

# Update all flake inputs
sudo nix flake update
```

## Repository layout

```
flake.nix              # Entry point
outputs/               # Wires home-conf and nixos-conf from inputs
home/
  home.nix             # Home-manager root: packages + ~/.config symlinks
  programs/            # home-manager program modules (auto-imported)
  config/              # Raw config files (sway, helix, waybar, zellij, etc.)
system/
  packages.nix         # System-wide packages
  <machine>.nix        # Per-machine module imports + stateVersion
  machine/             # hardware-configuration.nix per machine
  modules/             # Shared NixOS modules (audio, fonts, networking, etc.)
x/                     # Rust source for the `nix run .#x` CLI tool
docs/                  # Reference docs for coding agents (see below)
notes/                 # Human-oriented setup and troubleshooting notes
```

## Further reading

Detailed reference docs live in `docs/`:

- [`docs/architecture.md`](docs/architecture.md) — how flake outputs, home-manager, and NixOS layers connect
- [`docs/x-tool.md`](docs/x-tool.md) — full reference for the `x` Rust CLI: what each menu action does, the exact commands it runs, source layout, and caveats
- [`docs/patterns.md`](docs/patterns.md) — how to add program modules, raw config files, NixOS modules, system packages, and new machines
- [`docs/ops.md`](docs/ops.md) — wifi, audio, Chinese input, SOPS secrets, display configuration
