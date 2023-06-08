# User configurations.

{ config, pkgs, ... } :

{
  imports = [
    # Add Home Manager
    <home-manager/nixos>

    ./alek.nix
  ];
}
