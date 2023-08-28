# Reference: https://github.com/nix-community/home-manager/blob/master/modules/programs/git.nix
{ pkgs, ... } :
let
  gitConfig = {
    core = {
      editor = "nvim";
    };
    init.defaultBranch = "main";
  };

  deltaConfig = {
    enable = true;
    options = {
      line-numbers = true;
      navigate = true;
      side-by-side = true;
      syntax-theme = "Dracula";
    };
  };

  signingConfig = {
    key = builtins.readFile ./keyid;
    signByDefault = true;
  };
in
{
  programs.git = {
    delta = deltaConfig;
    enable = true;
    extraConfig = gitConfig;
    userEmail = "62207329+asungy@users.noreply.github.com";
    userName = "asungy";
  };
}
