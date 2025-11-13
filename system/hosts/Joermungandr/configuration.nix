{
  pkgs,
  ...
}:
{
  networking.hostName = "Joermungandr";

  # nixpkgs.config.rocmSupport = true;
  # hardware.graphics.extraPackages = with pkgs; [
  #   pocl
  #   rocmPackages.clr.icd
  # ];

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    systemd-boot.configurationLimit = 5;
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  system.autoUpgrade = {
    enable = true;
    dates = "weekly";
    allowReboot = true;
    rebootWindow = {
      lower = "01:00";
      upper = "05:00";
    };
    flags = [
      "--update-input"
      "nixpkgs"
      "--commit-lock-file"
    ]; # Update flake inputs too
    flake = "gitlab:Drakolis/nix-nyx";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # File system support
    exfatprogs
    apfsprogs
    ntfs3g

    # Nix Specific
    home-manager
  ];

  services = {
    # Enable CUPS to print documents.
    printing = {
      enable = true;
      browsing = false;
      listenAddresses = [ "localhost:631" ]; # Only listen on localhost
      allowFrom = [ "localhost" ];
      defaultShared = false;
    };

    # Enable firmware updating
    fwupd.enable = true;

    fcron.enable = true;

    # Enable sound with pipewire.
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      # jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      # media-session.enable = true;
    };
  };

  # Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ ]; # Explicitly allow only needed ports
    allowedUDPPorts = [ ];
    logRefusedConnections = false; # Reduce log noise (set to true if debugging)
  };

  # SSH Access
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      X11Forwarding = false;
      AllowTcpForwarding = false;
      AllowAgentForwarding = false;
      PermitEmptyPasswords = false;
      MaxAuthTries = 3;
      MaxSessions = 2;
      LoginGraceTime = 30;
      ClientAliveInterval = 300;
      ClientAliveCountMax = 2;
      UseDns = false;
      TCPKeepAlive = false;
      Compression = false;
      LogLevel = "VERBOSE";
      StrictModes = true;
      Protocol = 2;
    };
  };

  # Mobile SSH
  programs.mosh.enable = true;

  drakolis = {
    desktop = {
      enable = true;
      types = [
        "kde"
      ];
    };
    gaming.enable = true;
    geolocation.enable = true;
    ki.enable = true;
    virtualization = {
      enable = true;
      type = "amd";
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
