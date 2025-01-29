{ pkgs, ... } :
let
  username = "asungy";
  homeDirectory = "/home/${username}";

  defaultPkgs = with pkgs; [
    anki           # Spaced repetition flashcards
    bat            # A better `cat`
    brave          # Browser
    cloc           # Line counter
    devenv         # Nix dev environments
    dropbox        # Cloud filesystem
    eza            # A better `ls`
    ffmpeg         # OP media software
    ghostty        # Terminal emulator
    helix          # Post-modern modal editor
    htop           # Resource viewer
    jq             # Steroids for JSON
    keepassxc      # Password manager
    obsidian       # Note-taking app
    prismlauncher  # Minecraft launcher
    rclone         # Cloud client
    remmina        # RDP Client
    ripgrep        # A better `grep`
    signal-desktop # Text messaging
    tldr           # All the manpages
    tree           # File tree viewer
    vlc            # Video player
    zellij         # Terminal workspace
    zoom-us        # Video conferencing
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

      # XDG WLR nonsense
      ".config/xdg-desktop-portal/wlr-portals.conf".source = ./config/wlr-portals.conf;

      # Sway
      ".config/sway/config".source = ./config/sway/config;
      ".config/swayidle/config".source = ./config/swayidle.conf;
      ".config/swaylock.sh".source = ./config/swaylock.sh;
      ".config/waybar/config".source = ./config/waybar/config;
      ".config/waybar/style.css".source = ./config/waybar/style.css;
      ".config/wofi/config".source = ./config/wofi.conf;

      # i3
      ".config/i3/config".source = ./config/i3/config;
    };
  };
}
