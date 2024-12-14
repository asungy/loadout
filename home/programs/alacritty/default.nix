{ pkgs, ... } :
let
  colorTheme = {
    # Tokyonight-night (https://github.com/folke/tokyonight.nvim)
    primary = {
      background = "0x1a1b26";
      foreground = "0xc0caf5";
    };

    normal = {
      black =   "0x15161e";
      red =     "0xf7768e";
      green =   "0x9ece6a";
      yellow =  "0xe0af68";
      blue =    "0x7aa2f7";
      magenta = "0xbb9af7";
      cyan =    "0x7dcfff";
      white =   "0xa9b1d6";
    };

    bright = {
      black =   "0x414868";
      red =     "0xf7768e";
      green =   "0x9ece6a";
      yellow =  "0xe0af68";
      blue =    "0x7aa2f7";
      magenta = "0xbb9af7";
      cyan =    "0x7dcfff";
      white =   "0xc0caf5";
    };

    indexed_colors = [
      { index = 16; color = "0xff9e64"; }
      { index = 17; color = "0xdb4b4b"; }
    ];
  };

  fontConfig = {
    size = 14;
  };
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      colors = colorTheme;
      font = fontConfig;
      shell.program = "${pkgs.tmux}/bin/tmux";
      window.decorations = "none"; # Hide title bar
      window.opacity = 0.85;
    };
  };
}
