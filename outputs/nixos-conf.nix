{ inputs, system, ... } :
  let
    inherit (inputs.nixpkgs.lib) nixosSystem;

    pkgs = import inputs.nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
  in
{
  dell-g5 = nixosSystem {
    inherit pkgs system;
    specialArgs = { inherit inputs; };
    modules = [
      ../system/machine/dell-g5
      ../system/configuration.nix
    ];
  };
}
