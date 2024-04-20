{ inputs, system, ... } :
  let
    inherit (inputs.home-manager.lib) homeManagerConfiguration;

    unstable = import inputs.unstable-nixpkgs {
      inherit system;
    };

    overlays = [
      (final: prev: {
        brave = unstable.brave;
      })
    ];

    pkgs = import inputs.pinned-nixpkgs {
      inherit system overlays;
      config.allowUnfree = true;
    };

    imports = [
      ../home/home.nix
    ];
  in
{
  asungy = homeManagerConfiguration {
    inherit pkgs;
    modules = [{ inherit imports; }];
  };
}
