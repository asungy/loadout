# Reference: https://github.com/nix-community/home-manager/blob/master/modules/programs/bash.nix
{ ... } :
let
  shellAliases = {
    cpwd = "pwd | wl-copy";
    f = "fuck";
    l = "eza";
    sway = "sway --unsupported-gpu";
    xv = "nix run github:asungy/xvim";
  };

  sessionVariables = {};
in
{
  programs.bash = {
    inherit shellAliases sessionVariables;

    enable = true;
    enableCompletion = true;
    initExtra = builtins.readFile ./rc.sh;
  };
}
