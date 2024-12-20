# Reference: https://github.com/nix-community/home-manager/blob/master/modules/programs/bash.nix
{ ... } :
let
  shellAliases = {
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
    vim = "nix run github:asungy/xvim";
    f = "fuck";
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
