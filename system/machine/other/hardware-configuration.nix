# WARNING: This empty hardware configuraton file is here to allow the flake checking to
# pass for the other outputs (not this one). Use the `x` utility to generate
# the appropriate hardware configuraton file.

{ config, lib, pkgs, modulesPath, ... } : {
  fileSystems."/" =
    { device = "not a real device";
      fsType = "not a real filesystem type";
    };
}
