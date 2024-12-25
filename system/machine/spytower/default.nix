{ config, pkgs, ... } :
{
  imports = [
    # Hardware scan
    ./hardware-configuration.nix
  ];

  # Bootloader configuration.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 5;

  # Networking
  networking.hostName = "spytower";
}
