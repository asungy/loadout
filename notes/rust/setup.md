# Rust Development Setup

After switching to NixOS, Neovim's LSP servers (particularly rust-analyzer) no
longer work with the Mason plugin. Therefore, in
(#2)[https://github.com/asungy/loadout/pull/2], Mason was disabled and some
manual steps need to be taken to get the rust-analyzer server working.

Upon a new installation of NixOS and applying configurations from
[asungy/loadout](https://github.com/asungy/loadout.git), `rustup` is available
but not `rustc` or `rust-analyzer`.

To install `rustc`, run:
```bash
rustup default stable
```

Then to install `rust-analyzer`, run:
```bash
rustup component add rust-analyzer
```
