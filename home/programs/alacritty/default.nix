{ pkgs, ... } :
let
  fontConfig = {
    size = 10;
  };
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      font = fontConfig;
      shell.program = "${pkgs.tmux}/bin/tmux";
    };
  };
}
