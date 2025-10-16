{ pkgs, username, ... } :
{
  # User settings.
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = ["docker" "networkmanager" "wheel"];
    shell = pkgs.bash;
    password = "";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOSAEaZXnJmHWh5s6FT+XIPCS2qC+XDsjH6ECDrKfxD1 u0_a317@localhost"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL0tQTPfgUokkNR0aKsBVFs+tf+efUyx7T7cK4WuxhJh asungy@spytower"
    ];
  };
  users.groups.plugdev.members = [ username ];

  # Grants additional rights to users connecting to Nix daemon.
  nix.settings.trusted-users = ["root" username];

  # Don't prompt for sudo password.
  security.sudo.extraRules = [
    {
      users = [username];
      commands = [
        {
          command = "ALL";
          options = ["NOPASSWD"];
        }
      ];
    }
  ];
}
