{ pkgs } :
{
  # Desktop environment.
  desktop = with pkgs; [
    brightnessctl             # Brightness controller
    dunst                     # Notification daemon
    libnotify                 # Notification library
    swayidle                  # Idle daemon
    swaylock-effects          # Screen locker
    waybar                    # Wayland bar
    wl-clipboard              # Clipboard/Terminal conduit
    wmenu                     # Dynamic Sway menu
    wofi                      # Launcher/menu program
    xdg-desktop-portal-wlr    # Desktop portal (allows for screensharing on Wayland)
  ];

  # Applications.
  apps = with pkgs; [
    flameshot                 # Screenshot utility
    helix                     # Text editor
    obs-studio                # Screen recorder
    obs-studio-plugins.wlrobs # OBS wayland plugin
    satty                     # Image annotation tool
    ventoy                    # Bootable USB utility; labeled as insecure (2025-06-06)
    vesktop                   # Discord client
  ];

  misc = with pkgs; [
    pavucontrol               # PulseAudio GUI
    pinentry-curses           # GnuPG interface
  ];
}
