# Placeholder — regenerate on labboi by running: nix run .#x -> Generate hardware config
{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  # Stub root filesystem so the flake evaluates before hardware is scanned.
  # Replace by running: nix run .#x -> Generate hardware config -> labboi
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "virtio_pci" "sd_mod" ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];
}
