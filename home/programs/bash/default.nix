# Reference: https://github.com/nix-community/home-manager/blob/master/modules/programs/bash.nix
{ pkgs, ... } :
let
  aliases = {
    archbox = "docker run --network=host -it --rm --name=archbox archlinux:latest /bin/bash";
    archbox-mnt = (
      "docker run --network=host -it --rm " +
      "--name=archbox-mnt " +
      "--workdir=/mnt/\"\$\{PWD##*/}\" " +
      "--volume=\"\$(pwd)\":/mnt/\"\$\{PWD##*/}\" " +
      "archlinux:latest /bin/bash"
    );
    cpwd = "pwd | wl-copy";
    ls = "ls --color=tty";
    li = "ls --color=tty"; # easier typing for dvorak
    vim = "nvim";
    nxm = "nix run github:asungy/nixim";
  };
  cmdsForInteractiveShell = builtins.readFile ./rc.sh;
in
{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = cmdsForInteractiveShell;
    shellAliases = aliases;
  };
}
