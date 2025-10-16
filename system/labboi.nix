{ pkgs, ... } :
let
  packages = import ./packages.nix { inherit pkgs; };
in
{
  imports = [
    ./modules/audio.nix
    ./modules/environment_vars.nix
    ./modules/fonts.nix
    ./modules/graphics/default.nix
    ./modules/i18n.nix
    ./modules/nix_daemon.nix
    ./modules/user.nix
    ./modules/wayland.nix
    ./modules/networking.nix
  ];

  environment.systemPackages = packages.desktop
    ++ packages.apps
    ++ packages.misc
    ;

  # Reference: https://nixos.wiki/wiki/SSH
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      AllowUsers = ["termux"];
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "no";
    };
  };
  networking.firewall.allowedTCPPorts = [ 22 ];

  # Added Termux user.
  users.users.termux = {
    isNormalUser = true;
    extraGroups = ["docker" "networkmanager" "wheel"];
    shell = pkgs.bash;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOSAEaZXnJmHWh5s6FT+XIPCS2qC+XDsjH6ECDrKfxD1 u0_a317@localhost"
    ];
  };

  # Update dynamic DNS service.
  systemd.services.duckdns =
  let
    # TODO: Move this to SOPS
    duckdnsSecrets = builtins.fromJSON (builtins.readFile /etc/nixos/duckdns.json);
  in
  {
    description = "Update DuckDNS";
    serviceConfig = {
      Type = "simple";
      ExecStart = ''
        ${pkgs.curl}/bin/curl "https://www.duckdns.org/update?domains=${duckdnsSecrets.domain}&token=${duckdnsSecrets.token}&ip="
      '';
    };
  };
  systemd.timers.duckdns = {
    description = "Periodic update of DuckDNS IP";
    timerConfig = {
      OnBootSec = "5min";
      OnUnitActiveSec = "5min";
    };
    wantedBy = [ "timers.target" ];
    unit = "duckdns.service";
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?
}

