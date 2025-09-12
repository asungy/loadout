{ config, pkgs, ... } :
{
  imports = [
    # Hardware scan
    ./hardware-configuration.nix
  ];

  # Bootloader configuration.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";

  # Networking
  networking.hostName = "nixos";
}
