In order to update nix packages to pull the newest versions of packages, run the following:
```bash
sudo nix flake update
```

This will update the `flake.lock` file with a newer version for nixpkgs. This
may also update other packages that are not managed by home-manager as well. If
running a `x fresh` causes a build error, then on stage the changes to the
nixpkgs version (via `git add -p`).
