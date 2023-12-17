{ pkgs, inputs, config, ... } :
  let
    udevRules = pkgs.callPackage ./udev/default.nix { inherit pkgs; };
    username = "asungy";
in {
  imports = [];

  # System packages.
  environment.systemPackages = with pkgs; [
    brightnessctl               # Brightness controller
    dunst                       # Notification daemon
    hyprpaper                   # Wallpaper manager
    neovim                      # Ok text editor
    obs-studio                  # Screen recorder*
    obs-studio-plugins.wlrobs   # OBS wayland plugin
    pavucontrol                 # PulseAudio GUI
    pinentry-curses             # GnuPG interface
    wofi                        # Launcher/menu program
    xdg-desktop-portal-hyprland # Desktop portal
  ];
  # * Note: this needs to be installed on the system (and not through a shell)
  # to work properly with graphics drivers on Wayland.

  # Networking
  networking = {
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };

    wireless.iwd.enable = true;

    firewall.enable = true;
  };

  # Wayland compositor
  programs.hyprland.enable = true;

  # Environment variables
  environment.variables = {
    # Set IBUS environment variables.
    GTK_IM_MODULE = "ibus";
    QT_IM_MODULE = "ibus";
    XMODIFIERS = "@im=ibus";
    # Set default editor.
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Set up input methods (keyboards).
  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [ libpinyin ];
  };

  # Install custom udev configurations.
  services.udev.packages = [ udevRules ];

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    powerManagement.enable = false;
    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
	# accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # Fonts.
  fonts.packages = [
    (pkgs.nerdfonts.override {
      fonts = [ "FiraCode" ];
    })
  ];

  # Add user to plugdev.
  users.groups.plugdev.members = [ username ];

  # GPG setup.
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "curses";
    enableSSHSupport = true;
  };

  # User.
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = ["docker" "networkmanager" "wheel"];
    shell = pkgs.bash;
    password = "";
  };

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

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Nix daemon config.
  #
  # Reference: https://nixos.org/manual/nix/stable/command-ref/conf-file.html
  nix = {
    # Automate garbage collection.
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    # Flakes settings
    package = pkgs.nixVersions.stable;
    registry.nixpkgs.flake = inputs.nixpkgs;

    settings = {
      # Automate `nix store optimise`. This saves disk space.
      auto-optimise-store = true;

      # Grants additional rights to users connecting to Nix daemon.
      trusted-users = ["root" username];

      # Allow experimental features.
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  # Enable Docker.
  virtualisation = {
    docker = {
      enable = true;

      autoPrune = {
        enable = true;
        dates = "weekly";
      };

      # NOTE: This was causing networking issues with Docker, particularly when
      # trying to connect to a server hosted in a container through the host
      # machine.
      #
      # rootless = {
      #   enable = true;
      #   setSocketVariable = true;
      # };
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
