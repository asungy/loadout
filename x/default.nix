{inputs, system} :
let
  overlays = [ (import inputs.rust-overlay) ];
  pkgs = import inputs.nixpkgs { inherit system overlays; };
in
pkgs.rustPlatform.buildRustPackage {
  name = "x";
  src = pkgs.lib.cleanSource ./.;

  cargoLock.lockFile = ./Cargo.lock;
  cargoBuildFlags = "--release";
}
