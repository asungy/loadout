{
  description = "asungy's Home Manager and NixOS configurations";

  inputs = {
    # Original: nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    #
    # Pinning nixpkgs until Nvidia stops shitting the bed.
    nixpkgs.url = "github:NixOS/nixpkgs/bb2b73df7bcfbd2dd55ff39b944d70547d53c267";

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
  };
}
