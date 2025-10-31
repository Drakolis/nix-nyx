{ pkgs, ... }:
{
  networking.hostName = "WinterDragon";

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

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # File system support
    exfatprogs

    # Nix Specific
    home-manager

    # Power management
    acpi
    powertop
  ];

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 35;

      #Optional helps save long term battery health
      # START_CHARGE_THRESH_BAT0 = 40; # 40 and below it starts to charge
      # START_CHARGE_THRESH_BAT1 = 40; # 40 and below it starts to charge
      # STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
      TPSMAPI_ENABLE = 1;
    };
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

  # SSH Access
  services.openssh = {
    enable = false; # Should not be accessible on SSH
  };

  # Mobile SSH
  programs.mosh.enable = true;

  drakolis = {
    desktop = {
      enable = true;
      types = [
        "hyprland"
        "niri"
      ];
    };
    geolocation.enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
