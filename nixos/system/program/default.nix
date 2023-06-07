# System-wide programs.

{ config, pkgs, ... } :

{
  imports = [
    ./docker.nix
  ];
}
