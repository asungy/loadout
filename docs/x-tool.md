# The `x` Tool

`x` is a small Rust CLI that wraps common NixOS/home-manager operations behind an interactive `inquire` menu. All menus support vim-mode navigation (j/k).

## Running

```bash
nix run .#x        # build and run from flake
```

Must be run from the repository root — several actions depend on `std::env::current_dir()`.

## Menu options

### Build home manager

Runs two commands in sequence:

```bash
sudo nix build .#homeConfigurations.asungy.activationPackage
result/activate
```

The username `asungy` is hardcoded in `x/src/core/home_manager.rs`.

### Build system

Prompts for a machine (`framework` | `spytower` | `kvm`) and a subcommand (`switch` | `boot` | `test`), then runs:

```bash
sudo nixos-rebuild <subcommand> --upgrade --flake .#<machine>
```

Machine names and subcommands are hardcoded in `x/src/prompt/build_system.rs`. Adding a new machine requires editing that file and rebuilding.

The same file also contains a `generate_hardware_file()` helper that runs `nixos-generate-config` into a tempdir and copies the result to `system/machine/<name>/hardware-configuration.nix`.

### Set wallpaper

Presents a list of named wallpapers (hardcoded in `x/src/prompt/set_wallpaper.rs`). The selected file is copied from `wallpapers/` to `~/.wallpaper`, then `swaymsg reload` is called to apply it.

Available wallpapers: Elden Ring, Skyrim, Musashi Miyamoto, NixOS Honeycombs.

To add a wallpaper: drop the image into `wallpapers/`, add a constant and match arm in `set_wallpaper.rs`, and rebuild `x`.

### Set monitor

Toggles laptop display (`eDP-1`) on or off. It does this by toggling the comment on the line:

```
output "eDP-1" disable
```

in `home/config/sway/config` (path hardcoded as `SWAY_CONFIG_FILE`). After editing the file it offers to run the home-manager build immediately.

## Source layout

```
x/
  Cargo.toml              # deps: anyhow, colored, inquire, home, tempfile, aes-gcm, sha2
  Cargo.lock
  default.nix             # builds with rustPlatform.buildRustPackage + rust-overlay
  src/
    main.rs               # entry point; drives the prompt loop
    core/
      mod.rs
      home_manager.rs     # build() — the two-step nix build + activate
    prompt/
      mod.rs              # initial menu; dispatches to sub-modules
      build_home_manager.rs
      build_system.rs     # also contains generate_hardware_file()
      set_wallpaper.rs
      set_monitor.rs
```

## Important caveats

- The tool must be run from the **repository root**. `set_monitor` reads `home/config/sway/config` relative to `current_dir()`, and `set_wallpaper` resolves `wallpapers/` the same way.
- `set_monitor` directly mutates `home/config/sway/config` on disk. After toggling, commit the change if it should be persisted.
- The home-manager build step uses a hardcoded username (`asungy`). If the username changes, update `x/src/core/home_manager.rs`.
- After any code change to `x/`, the flake package must be rebuilt (`nix build .#x`) before `nix run .#x` picks up the change.
