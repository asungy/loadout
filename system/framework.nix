{ pkgs, ... } :
let
  packages = import ./packages.nix { inherit pkgs; };
in
{
  imports = [
    ./modules/audio.nix
    ./modules/environment_vars.nix
    ./modules/fonts.nix
    ./modules/gpg.nix
    ./modules/graphics
    ./modules/i18n.nix
    ./modules/networking.nix
    ./modules/nix_daemon.nix
    # ./modules/protonvpn.nix
    ./modules/tablet.nix
    ./modules/udev
    ./modules/user.nix
    ./modules/virtualisation.nix
    ./modules/wayland.nix
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
