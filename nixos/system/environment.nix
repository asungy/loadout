# Environment configuration.

{ config, pkgs, ... } :

{
  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    neovim
    python312
  ];

  # Set environment variables.
  environment.variables = {
    # Set IBUS environment variables.
    GTK_IM_MODULE = "ibus";
    QT_IM_MODULE = "ibus";
    XMODIFIERS = "@im=ibus";
    # Set default editor.
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
