{ inputs, system, ... } :
  let
    inherit (inputs.nixpkgs.lib) nixosSystem;

    pkgs = import inputs.nixpkgs {
      inherit system;
      overlays = [ inputs.nix-minecraft.overlay ];
      config = {
        allowUnfree = true;
      };
    };
  in
{
  sway = nixosSystem {
    inherit pkgs system;
    specialArgs = { inherit inputs; };
    modules = [
      ../system/machine/framework
      ../system/sway.nix
    ];
  };
}
