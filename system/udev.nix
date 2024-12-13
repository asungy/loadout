{ pkgs, ... } :
{
  # Install custom udev configurations.
  services.udev.packages = [
    (import ./udev/zsa.nix { inherit pkgs; })
    pkgs.android-udev-rules
  ];
}
