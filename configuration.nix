# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  inputs,
  ...

}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.nix-index-database.nixosModules.nix-index
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  };

  networking = {
    hostName = "performante";
    networkmanager.enable = true;
    firewall = {
      allowedUDPPorts = [ 5353 ];
      allowedTCPPorts = [ 57621 ];
    };
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
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
  };

  services.xserver = {
    enable = true;
    # desktopManager.gnome.enable = true;
    # displayManager.gdm.enable = true;
    videoDrivers = [ "nvidia" ];

    xkb = {
      layout = "us";
      variant = "";
    };
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd 'niri-session'";
        user = "greeter";
      };
    };
  };

  hardware.graphics.enable = true;

  hardware.nvidia = {
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    nvidiaPersistenced = true;
    modesetting.enable = true;
    forceFullCompositionPipeline = true;
  };

  # Enable polkit
  security.polkit.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.koehn = {
    isNormalUser = true;
    description = "Koehn";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.fish;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.koehn = import ./modules/home { inherit pkgs inputs; };
  };

  programs.nix-index-database.comma.enable = true;

  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixVersions.latest;
    settings = {
      warn-dirty = false;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://aseipp-nix-cache.freetls.fastly.net"
        "niri.cachix.org"
      ];
    };
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Enable vendor completions
  programs.fish.enable = true;

  environment.systemPackages = with inputs; [
    ghostty.packages.x86_64-linux.default
    nh.packages.x86_64-linux.default
  ];

  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  programs.niri = {
    package = pkgs.niri-unstable;
    enable = true;
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    nerd-fonts.commit-mono
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "koehn" ];
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
