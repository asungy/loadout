{ config, lib, pkgs, stdenv, nixim, ... } :
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
    waybar          # Wayland bar
    wl-clipboard    # Clipboard/Terminal conduit
    xclip           # Clipboard/Terminal conduit
  ];

  required = with pkgs; [
    gcc13
    llvmPackages_16.clang-unwrapped
    nodejs_20
    python312
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

    packages = defaultPkgs ++ required ++ [nixim];

    stateVersion = "23.05";
  };
}
