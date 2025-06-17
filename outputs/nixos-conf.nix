{ inputs, system, ... } :
  let
    inherit (inputs.nixpkgs.lib) nixosSystem;

    pkgs = import inputs.nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
        permittedInsecurePackages = [ "ventoy-1.1.05" ];
      };
    };
  in
{
  # Desktop output.
  spytower = nixosSystem {
    inherit pkgs system;
    modules = [
      ../system/machine/spytower
      ../system/spytower.nix
    ];
    specialArgs = { inherit inputs; username = "asungy"; };
  };

  # Generic output.
  framework = nixosSystem {
    inherit pkgs system;
    modules = [
      ../system/machine/framework
      ../system/framework.nix
    ];
    specialArgs = { inherit inputs; username = "asungy"; };
  };

  # Generic output.
  #
  # TODO implement
  #
  # other = nixosSystem {
  #   inherit pkgs system;
  #   modules = [
  #     ../system/machine/other
  #     ../system
  #   ];
  #   specialArgs = { inherit inputs; username = "asungy"; };
  # };
}
