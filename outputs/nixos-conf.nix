{ inputs, system, ... } :
  let
    inherit (inputs.pinned-nixpkgs.lib) nixosSystem;

    unstable = import inputs.unstable-nixpkgs {
      inherit system;
    };

    overlays = [
      (final: prev: {
        hyprland = unstable.hyprland;
      })
    ];

    pkgs = import inputs.pinned-nixpkgs {
      inherit system overlays;
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
