# Common Patterns

## Adding a home-manager program module

1. Create `home/programs/<name>/default.nix` returning a home-manager module:
   ```nix
   { pkgs, ... }: {
     programs.<name> = {
       enable = true;
       # ...
     };
   }
   ```
2. Add `./name` to the list in `home/programs/default.nix`.

It will be picked up automatically — `home/home.nix` imports the whole list via `builtins.concatMap import [./programs]`.

## Adding a raw config file to home-manager

For tools without a home-manager program option, add a `home.file` entry in `home/home.nix`:

```nix
home.file.".config/<tool>/config".source = ./config/<tool>/config;
```

Place the config file at `home/config/<tool>/config`.

## Adding a NixOS module

1. Create `system/modules/<name>.nix`.
2. Add it to the `imports` list in the relevant `system/<machine>.nix` files.

## Adding a system package

Add the package to the appropriate list in `system/packages.nix` (`desktop`, `apps`, or `misc`).

## Adding a new machine

1. Run `sudo nixos-generate-config --dir <tmpdir>` on the target machine to get `hardware-configuration.nix`.
2. Create `system/machine/<name>/` and place `hardware-configuration.nix` there with a `default.nix` that imports it.
3. Create `system/<name>.nix` (copy an existing one and adjust module imports).
4. Register it in `outputs/nixos-conf.nix`:
   ```nix
   <name> = nixosSystem {
     inherit pkgs system;
     modules = [
       ../system/machine/<name>
       ../system/<name>.nix
     ];
     specialArgs = { inherit inputs; username = "asungy"; };
   };
   ```
5. The `x` tool's `build_system.rs` hardcodes the machine list — add `<name>` there and rebuild with `nix build .#x`.

## Updating flake inputs (nixpkgs, home-manager, etc.)

```bash
sudo nix flake update
```

Then rebuild home-manager and/or the system to apply changes.
