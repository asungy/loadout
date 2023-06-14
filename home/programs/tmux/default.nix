# Reference: https://github.com/nix-community/home-manager/blob/master/modules/programs/tmux.nix
{ pkgs, ... } :
let
  tmuxConfig = builtins.readFile ./tmux.conf;
in
{
  programs.tmux = {
    enable = true;
    escapeTime = 0;
    extraConfig = tmuxConfig;
    keyMode = "vi";
    package = pkgs.tmux-mem-cpu-load;
    shortcut = "a";
  };
}
