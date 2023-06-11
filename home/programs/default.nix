let
  more = { pkgs, ... } :
  {
    programs = {
      # https://github.com/nix-community/home-manager/blob/master/modules/programs/bash.nix
      bash = {
        enable = true;
        enableCompletion = true;
        shellAliases = {
          ls = "ls --color=tty";
          vim = "nvim";
        };
      };
      # https://github.com/nix-community/home-manager/blob/master/modules/programs/fzf.nix
      fzf = {
        enable = true;
        enableBashIntegration = true;
      };
    };
  };
in
[
  ./git
  more
]
