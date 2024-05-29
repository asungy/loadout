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
  i3 = nixosSystem {
    inherit pkgs system;
    specialArgs = { inherit inputs; };
    modules = [
      ../system/machine/framework
      ../system/i3.nix
    ];
  };

  sway = nixosSystem {
    inherit pkgs system;
    specialArgs = { inherit inputs; };
    modules = [
      ../system/machine/framework
      ../system/sway.nix
    ];
  };
}
