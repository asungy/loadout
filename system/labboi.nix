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
    ./modules/tablet.nix
    ./modules/udev
    ./modules/ssh.nix
    ./modules/tailscale.nix
    ./modules/user.nix
    ./modules/virtualisation.nix
    ./modules/wayland.nix
  ];

  environment.systemPackages = []
    ++ packages.desktop
    ++ packages.apps
    ++ packages.misc
    ;
    
  system.stateVersion = "25.05"; # Did you read the comment?
}
