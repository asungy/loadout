{
  virtualisation = {
    # Enable Docker.
    docker = {
      enable = true;

      autoPrune = {
        enable = true;
        dates = "weekly";
      };

      # NOTE This was causing networking issues with Docker, particularly when
      # trying to connect to a server hosted in a container through the host
      # machine.
      #
      # rootless = {
      #   enable = true;
      #   setSocketVariable = true;
      # };
    };
  };
}
