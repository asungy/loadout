{ pkgs, inputs, ... } :
{
  # Nix daemon config.
  #
  # Reference: https://nixos.org/manual/nix/stable/command-ref/conf-file.html
  nix = {
    # Optimise nix store.
    optimise.automatic = true;
    # Automate garbage collection.
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    # Flakes settings
    package = pkgs.nixVersions.stable;
    registry.nixpkgs.flake = inputs.nixpkgs;

    settings = {
      # Automate `nix store optimise`. This saves disk space.
      auto-optimise-store = true;

      # Allow experimental features.
      experimental-features = [ "nix-command" "flakes" ];
    };
  };
}
