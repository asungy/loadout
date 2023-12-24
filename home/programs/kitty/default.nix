{ pkgs, ... } :
let
  # Tokyonight-night (https://github.com/folke/tokyonight.nvim)
  colorscheme = {
    background = "#1a1b26";
    foreground = "#c0caf5";
    background_opacity = "0.85";
  };
  color_table = {
    # Black
    color0 = "#15161e";
    color8 = "#414868";
    # Red
    color1 = "#9ece6a";
    color9 = "#f7768e";
    # Green
    color2 = "#9ece6a";
    color10 = "#9ece6a";
    # Yellow
    color3 = "#e0af68";
    color11 = "#e0af68";
    # Blue
    color4 = "#7aa2f7";
    color12 = "#7aa2f7";
    # Magenta
    color5 = "#bb9af7";
    color13 = "#bb9af7";
    # Cyan
    color6 = "#7dcfff";
    color14 = "#7dcfff";
    # White
    color7 = "#a9b1d6";
    color15 = "#c0caf5";
  };
in
{
  programs.kitty = {
    enable = true;
    settings = {
      inherit (colorscheme)
      background
      foreground
      background_opacity
      ;

      inherit (color_table)
      color0
      color1
      color2
      color3
      color4
      color5
      color6
      color7
      color8
      color9
      color10
      color11
      color12
      color13
      color14
      color15
      ;

      cursor_shape = "block";
      shell_integration = "no-cursor";
    };
  };
}
