{ config, lib, pkgs, stdenv, ... } :
let
  username = "asungy";
  homeDirectory = "/home/${username}";

  defaultPkgs = with pkgs; [
    delta
    ripgrep
    tmux
    tree
    xclip
  ];

  buildDeps = with pkgs; [
    git       # Required for Neovim.
    nodejs_20 # Required for Neovim.
    python312 # Required for Dropbox.
  ];
in
{
  programs.home-manager.enable = true;

  imports = builtins.concatMap import [
    ./programs
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