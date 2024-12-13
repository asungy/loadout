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
  # Desktop output.
  spytower = nixosSystem {
    inherit pkgs system;
    modules = [
      ../system/machine/spytower
      ../system
    ];
    specialArgs = { inherit inputs; username = "asungy"; };
  };

  # Generic output.
  framework = nixosSystem {
    inherit pkgs system;
    modules = [
      ../system/machine/framework
      ../system
    ];
    specialArgs = { inherit inputs; username = "asungy"; };
  };

  # Generic output.
  other = nixosSystem {
    inherit pkgs system;
    modules = [
      ../system/machine/other
      ../system
    ];
    specialArgs = { inherit inputs; username = "asungy"; };
  };
}
