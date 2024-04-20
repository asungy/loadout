{ inputs, system, ... } :
  let
    inherit (inputs.pinned-nixpkgs.lib) nixosSystem;

    pkgs = import inputs.pinned-nixpkgs {
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
