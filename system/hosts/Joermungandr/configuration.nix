{
  pkgs,
  lib,
  ...
}:
{
  networking.hostName = "Joermungandr";

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

  environment.systemPackages = with pkgs; [
    # File system support
    exfatprogs
    apfsprogs
    ntfs3g

    # Nix Specific
    home-manager

    # RGB
    openrgb-with-all-plugins
    i2c-tools
    liquidctl
  ];

  boot = {
    kernelParams = [ "acpi_enforce_resources=lax" ];
    kernelModules = [
      "i2c-dev"
      "i2c-piix4"
    ];
  };

  hardware.i2c.enable = true;

  services.hardware.openrgb = {
    enable = true;
    package = pkgs.openrgb.overrideAttrs (old: {
      src = pkgs.fetchFromGitLab {
        owner = "CalcProgrammer1";
        repo = "OpenRGB";
        rev = "release_candidate_1.0rc2";
        sha256 = "sha256-vdIA9i1ewcrfX5U7FkcRR+ISdH5uRi9fz9YU5IkPKJQ=";
      };
      patches = [
        ./remove_systemd_service.patch
      ];
      postPatch = ''
        patchShebangs scripts/build-udev-rules.sh
        substituteInPlace scripts/build-udev-rules.sh \
         --replace-fail /usr/bin/env "${pkgs.coreutils}/bin/env"
      '';
    });
    motherboard = "amd";
  };

  systemd.services.openrgb = lib.mkDefault {
    wantedBy = [ "multi-user.target" ];
    after = [
      "network.target"
      "lm_sensors.service"
    ];
    description = "OpenRGB SDK Server";
    serviceConfig = {
      RemainAfterExit = "yes";
      ExecStart = ''${pkgs.openrgb}/bin/openrgb --server'';
      Restart = "always";
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

  drakolis = {
    desktop = {
      enable = true;
      types = [
        # "kde"
        "niri"
      ];
      profiles = [
        "advanced"
        "downloads"
        "entertainment"
        "media"
        "office"
        "security"
        "remoteDesktop"
      ];
      terminal = "kitty";
    };
    dos.enable = true;
    input = {
      enable = true;
      hasGamepad = true;
      hasLogitech = true;
      hasVial = true;
    };
    gaming.enable = true;
    geolocation.enable = true;
    ki.enable = true;
    ssh.enable = true;
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
