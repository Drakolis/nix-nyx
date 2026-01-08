{ pkgs, ... }:
{
  networking.hostName = "Quetzalcoatl";

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    systemd-boot.configurationLimit = 2;
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  system.autoUpgrade = {
    enable = true;
    dates = "monthly";
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

  boot.supportedFilesystems = [ "exfat" ];

  environment.systemPackages = with pkgs; [
    # File system support
    exfatprogs

    # Nix Specific
    home-manager

    # Power management
    acpi
    powertop
  ];

  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-openconnect
      networkmanager-fortisslvpn
    ];
  };

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

  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  drakolis = {
    desktop = {
      enable = true;
      types = [
        # "kde"
        "niri"
      ];
      profiles = [
        "office"
        "security"
      ];
    };
    input = {
      enable = true;
      hasVial = true;
    };
    geolocation.enable = true;
    thunderbolt.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
