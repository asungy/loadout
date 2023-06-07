# Entrypoint file.

{ config, pkgs, ... } :

{
  imports = [
    # Include results from hardware scan.
    ./hardware-configuration.nix

    ./user
    ./system
  ];
}
