{ pkgs, ... } :
let
  packages = import ./packages.nix { inherit pkgs; };
in
{
  imports = [
    ./audio.nix
    ./environment_vars.nix
    ./fonts.nix
    ./gpg.nix
    ./graphics.nix
    ./i18n.nix
    ./networking.nix
    ./nix_daemon.nix
    ./udev.nix
    ./user.nix
    ./virtualisation.nix
    ./wayland.nix
    ./wgnord.nix
  ];

  environment.systemPackages = []
    ++ packages.desktop
    ++ packages.apps
    ++ packages.misc
    ;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
