{ pkgs, ... } :
{
  # Install custom udev configurations.
  services.udev.packages = [
    (import ./zsa.nix { inherit pkgs; })
  ];
}
