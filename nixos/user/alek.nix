# User configuration for "alek".

{ config, pkgs, ... }:
let
  username = "alek";
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz";
in
{
  # Import Home Manager.
  imports = [ (import "${home-manager}/nixos") ];

  # Define a user account.
  users.users.alek = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel"];
  };

  home-manager.users.alek = { pkgs, ... } :
  {
    home.username = "${username}";
    home.homeDirectory = "/home/${username}";

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

    programs.home-manager.enable = true;
    programs.bash.enable = true;

    # Shell aliases.
    programs.bash.shellAliases = {
      ls = "ls --color=tty";
      vim = "nvim";
    };

    home.stateVersion = "23.05";
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
