{ pkgs, username, ... } :
{
  # User settings.
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = ["docker" "networkmanager" "wheel"];
    shell = pkgs.bash;
    password = "";
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
