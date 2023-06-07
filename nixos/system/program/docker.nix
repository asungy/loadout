# Install and configure Docker.

{ config, pkgs, ... }:

{
  users.extraGroups.docker.members = [ "alek" ];
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
}
