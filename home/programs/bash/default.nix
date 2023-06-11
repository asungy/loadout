# Reference: https://github.com/nix-community/home-manager/blob/master/modules/programs/bash.nix
{ pkgs, ... } :
let
  aliases = {
    ls = "ls --color=tty";
    vim = "nvim";
  };
  cmdsForInteractiveShell = ''
  '';
in
{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = cmdsForInteractiveShell;
    shellAliases = aliases;
  };
}
