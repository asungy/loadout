{
  description = "asungy's Home Manager and NixOS configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/21b078306a2ab68748abf72650db313d646cf2ca";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay.url = "github:oxalica/rust-overlay";
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
  };
}
