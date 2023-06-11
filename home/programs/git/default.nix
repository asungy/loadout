# Reference: https://github.com/nix-community/home-manager/blob/master/modules/programs/git.nix
{ pkgs, ... } :
let
  gitConfig = {
    core = {
      editor = "nvim";
    };
    init.defaultBranch = "main";
  };
in
{
  programs.git = {
    enable = true;
    extraConfig = gitConfig;
    userEmail = "62207329+asungy@users.noreply.github.com";
    userName = "asungy";
    diff-so-fancy.enable = true;
  };
}
