# Reference: https://github.com/nix-community/home-manager/blob/master/modules/programs/git.nix
{ pkgs, ... }:
{
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      line-numbers = true;
      navigate = true;
      side-by-side = true;
      syntax-theme = "Dracula";
    };
  };

  programs.git = {
    enable = true;
    signing.format = "openpgp";
    settings = {
      core.editor = "hx";
      init.defaultBranch = "main";
      user = {
        email = "62207329+asungy@users.noreply.github.com";
        name = "asungy";
      };
    };
  };
}
