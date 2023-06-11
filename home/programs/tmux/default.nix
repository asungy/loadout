# Reference: https://github.com/nix-community/home-manager/blob/master/modules/programs/tmux.nix
{ pkgs, ... } :
let
  tmuxConfig = builtins.readFile ./tmux.conf;
in
{
  programs.tmux = {
    enable = true;
    extraConfig = tmuxConfig;
    escapeTime = 0;
    keyMode = "vi";
    shortcut = "a";
  };
}
