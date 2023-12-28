{ config, lib, pkgs, stdenv, ... } :
let
  username = "asungy";
  homeDirectory = "/home/${username}";

  defaultPkgs = with pkgs; [
    bat             # A better `cat`
    brave           # Browser
    chatgpt-cli     # Thing that talks like a human
    cloc            # Line counter
    dropbox         # Cloud filesystem
    git             # Version control
    htop            # Resource viewer
    keepassxc       # Password manager
    ripgrep         # A better `grep`
    tmux            # Terminal multiplexer
    todoist         # Todoist CLI
    tree            # File tree viewer
    waybar          # Wayland bar
    wl-clipboard    # Clipboard/Terminal conduit
    xclip           # Clipboard/Terminal conduit
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

    packages = defaultPkgs;

    stateVersion = "23.05";

    file = {
      ".config/hypr/hyprland.conf".source = ./config/hyprland.conf;
      ".config/hypr/hyprpaper.conf".source = ./config/hyprpaper.conf;
      ".config/waybar/config".source = ./config/waybar/config;
      ".config/waybar/style.css".source = ./config/waybar/style.css;
      ".config/wofi/config".source = ./config/wofi.conf;
    };
  };
}
