{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    let
      system = "x86_64-linux";
    in
  {
    homeConfigurations =
      import ./outputs/home-conf.nix { inherit inputs system; };

    nixosConfigurations =
      import ./outputs/nixos-conf.nix { inherit inputs system; };

    packages.${system}.x = import ./x { inherit inputs system; };

    devShells.${system}.default = (
      let
        overlays = [(import inputs.rust-overlay)];
        pkgs = import inputs.nixpkgs { inherit system overlays; };
      in
      pkgs.callPackage ./devShell.nix {}
    );
  };
}
