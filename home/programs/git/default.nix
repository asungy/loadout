# Reference: https://github.com/nix-community/home-manager/blob/master/modules/programs/git.nix
{ pkgs, ... } :
let
  gitConfig = {
    core = {
      editor = "nvim";
      pager = "delta --diff-so-fancy";
    };
    init.defaultBranch = "main";
    delta.enable = true;
  };
in
{
  programs.git = {
    enable = true;
    extraConfig = gitConfig;
    userEmail = "62207329+asungy@users.noreply.github.com";
    userName = "asungy";
  };
}
