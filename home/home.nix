{ config, lib, pkgs, stdenv, ... } :
let
  username = "asungy";
  homeDirectory = "/home/${username}";

  defaultPkgs = with pkgs; [
    delta
    dropbox
    git
    keepassxc
    ripgrep
    tmux
    tree
    xclip
  ];

  buildDeps = with pkgs; [
    python312 # Required for Dropbox.
  ];
in
{
  programs.home-manager.enable = true;

  imports = builtins.concatMap import [
    ./programs
    ./services
  ];

  home = {
    inherit username;
    inherit homeDirectory;

    packages = defaultPkgs ++ buildDeps;

    stateVersion = "23.05";
  };

  # Shell aliases.
  programs.bash.shellAliases = {
    ls = "ls --color=tty";
    vim = "nvim";
  };
}
