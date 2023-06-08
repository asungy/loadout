# System-wide programs.

{ config, pkgs, ... } :

{
  imports = [
    ./docker.nix
  ];

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    neovim
    python312
  ];

  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
    spectacle
  ];
}
