# User configuration for "alek".

{ config, pkgs, ... }:
let
  username = "alek";
in
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.alek = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel"];
    home = "/home/${username}";
    createHome = false;
  };

  home-manager.users.alek = { pkgs, ... } :
  {
    nixpkgs.config.allowUnfree = true;
    home.packages = with pkgs; [
      brave
      delta
      dropbox
      firefox
      flameshot
      git
      keepassxc
      nodejs_20
      ripgrep
      tmux
      xclip
    ];
    programs.bash.enable = true;
    home.stateVersion = "23.05";
  };

  # Shell aliases.
  programs.bash.shellAliases = {
    ls = "ls --color=tty";
    vim = "nvim";
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
