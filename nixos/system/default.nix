# System-wide configuration.

{ config, pkgs, ... } :

{
  imports = [
    ./audio.nix
    ./boot.nix
    ./env.nix
    ./locale.nix
    ./misc.nix
    ./networking.nix
    ./nix.nix
    ./program
    ./windowing.nix
  ];
}
