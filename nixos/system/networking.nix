# Network configurations.

{ config, pkgs, ... } :

{
  # Define hostname.
  networking.hostName = "nixos";
  # Enable networking
  networking.networkmanager.enable = true;
}
