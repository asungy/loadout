{ config, lib, pkgs, stdenv, ... } :
let
  username = "asungy";
  homeDirectory = "/home/${username}";

  defaultPkgs = with pkgs; [
    anki            # Spaced repetition flashcards
    bat             # A better `cat`
    brave           # Browser
    chatgpt-cli     # AI buddy
    cloc            # Line counter
    dropbox         # Cloud filesystem
    htop            # Resource viewer
    keepassxc       # Password manager
    ripgrep         # A better `grep`
    tree            # File tree viewer
    vesktop         # Discord client
    waybar          # Wayland bar
    wl-clipboard    # Clipboard/Terminal conduit
    xclip           # Clipboard/Terminal conduit
    zoom-us         # Video conferencing
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
      # GDB
      ".config/gdb/gdbinit".source = ./config/gdb/gdbinit;

      # Hyprland
      ".config/hypr/hyprland.conf".source = ./config/hyprland.conf;
      ".config/hypr/hyprpaper.conf".source = ./config/hyprpaper.conf;

      # Sway
      ".config/sway/config".source = ./config/sway/config;
      ".config/swayidle/config".source = ./config/swayidle.conf;
      ".config/swaylock.sh".source = ./config/swaylock.sh;
      ".config/waybar/config".source = ./config/waybar/config;
      ".config/waybar/style.css".source = ./config/waybar/style.css;
      ".config/wofi/config".source = ./config/wofi.conf;

      # i3
      ".xinitrc".source = ./config/i3/xinitrc;
      ".config/i3/config".source = ./config/i3/config;
    };
  };
}
