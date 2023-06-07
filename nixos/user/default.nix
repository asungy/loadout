# User configuration (for single-user).

{ config, pkgs, ... }:
let
  username = "alek";
in
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.alek = {
    isNormalUser = true;
    description = username;
    extraGroups = [ "networkmanager" "wheel"];
    packages = with pkgs; [
      brave
      delta
      dropbox
      firefox
      git
      keepassxc
      ripgrep
      tmux
      xclip
    ];
  };

  # Don't prompt for sudo password.
  #
  # Reference: https://discourse.nixos.org/t/dont-prompt-a-user-for-the-sudo-password/9163/2
  security.sudo.extraRules = [
    {
      users = [username];
      commands = [
        {
          command = "ALL";
          options = ["NOPASSWD"];
        }
      ];
    }
  ];
}
