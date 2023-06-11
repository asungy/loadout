{ config, pkgs, ... } :
{
  imports = [
    # Hardware scan
    ./hardware-configuration.nix
  ];

  # Bootloader configuration.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "dell-g5";
}
