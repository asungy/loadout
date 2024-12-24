{
  # Wayland compositors
  programs.sway.enable = true;
  services.dbus.enable = true;

  # For swaylock to recognize user password
  security.pam.services.swaylock = {};

  # Environment variables
  environment.variables = {
    # Prevent flickering caused by nvidia drivers.
    WLR_RENDERER = "vulkan";
    # XDG
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "sway";
  };
}
