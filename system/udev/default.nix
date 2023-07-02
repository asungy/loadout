# Source: https://discourse.nixos.org/t/creating-a-custom-udev-rule/14569
{ pkgs, ... } :
pkgs.stdenv.mkDerivation {
  name = "zsa-udev-rules";

  src = ./rules;

  dontBuild = true;
  dontConfigure = true;

  installPhase = ''
    mkdir -p $out/etc/udev/rules.d
    cp 50-zsa.rules $out/etc/udev/rules.d
  '';
}
