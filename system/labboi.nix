{ pkgs, ... } :
{
  imports = [
    ./modules/nix_daemon.nix
    ./modules/ssh.nix
    ./modules/tailscale.nix
    ./modules/user.nix
  ];

  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

  system.stateVersion = "25.05"; # Did you read the comment?
}
