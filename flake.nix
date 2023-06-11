{
  description = "asungy's Home Manager and NixOS configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";

    home-manager = {
      url = "github:nix-community/home-manager";
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
  };
}
