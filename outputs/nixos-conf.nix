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
    # Not exactly sure what this does...be wary.
    specialArgs = { inherit inputs; };
    modules = [
      ../system/machine/dell-g5
      ../system/configuration.nix
    ];
  };
}
