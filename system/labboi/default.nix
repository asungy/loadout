{ pkgs, ... } :
let
  packages = import ../packages.nix { inherit pkgs; };
in
{
  imports = [
    ../modules/audio.nix
    ../modules/environment_vars.nix
    ../modules/fonts.nix
    ../modules/graphics/default.nix
    ../modules/i18n.nix
    ../modules/networking.nix
    ../modules/nix_daemon.nix
    ../modules/wayland.nix
    ./sshd.nix
    ./user.nix
    ./duckdns.nix
  ];

  environment.systemPackages = packages.desktop
    ++ packages.apps
    ++ packages.misc
    ;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?
}

