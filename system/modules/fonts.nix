{ pkgs, ... } :
{
  fonts.packages = [
    pkgs.nerd-fonts.fira-code
    pkgs.noto-fonts-cjk-sans
  ];
}
