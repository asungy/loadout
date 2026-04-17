{ pkgs, username, ... } :
{
  # User settings.
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = ["docker" "networkmanager" "wheel"];
    shell = pkgs.bash;
    password = "";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFdsO5C3hrbizm+ChTjGNPsKG6VKM6uWSEfF2t9aqIHB termux@phone"
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
