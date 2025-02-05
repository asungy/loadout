# Reference: https://github.com/nix-community/home-manager/blob/master/modules/programs/git.nix
{ pkgs, ... } :
let
  gitConfig = {
    core = {
      editor = "hx";
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
    key = "1E92C5ADF20FAFDB85F4D7659CBD0E31D59E4E72";
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
