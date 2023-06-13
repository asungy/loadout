{ config, lib, pkgs, stdenv, ... } :
let
  username = "asungy";
  homeDirectory = "/home/${username}";

  defaultPkgs = with pkgs; [
    bat             # A better `cat`
    brave           # Browser
    cloc            # Line counter
    dropbox         # Cloud filesystem
    git             # Version control
    htop            # Resource viewer
    keepassxc       # Password manager
    ripgrep         # A better `grep`
    tmux            # Terminal multiplexer
    tree            # File tree viewer
    xclip           # Clipboard/Terminal conduit
  ];

  dev = with pkgs; [
    deno
    nodejs_20
    python312
    rustup
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

    packages = defaultPkgs ++ dev;

    stateVersion = "23.05";
  };
}
