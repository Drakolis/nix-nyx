{ pkgs, ... }: {
  imports = [
    ./modules/firefox.nix
    ./modules/flatpak.nix
    ./modules/fonts.nix
    ./modules/gaming.nix
    ./modules/geolocation.nix
    ./modules/input.nix
    ./modules/ki.nix
    ./modules/nix.nix
    ./modules/shell.nix
    ./modules/tailscale.nix
  ];

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_IE.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IE.UTF-8";
    LC_IDENTIFICATION = "en_IE.UTF-8";
    LC_MEASUREMENT = "en_IE.UTF-8";
    LC_MONETARY = "en_IE.UTF-8";
    LC_NAME = "en_IE.UTF-8";
    LC_NUMERIC = "en_IE.UTF-8";
    LC_PAPER = "en_IE.UTF-8";
    LC_TELEPHONE = "en_IE.UTF-8";
    LC_TIME = "en_IE.UTF-8";
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  networking.networkmanager.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;

    settings.General = {
      experimental = true; # show battery

      # https://www.reddit.com/r/NixOS/comments/1ch5d2p/comment/lkbabax/
      # for pairing bluetooth controller
      Privacy = "device";
      JustWorksRepairing = "always";
      Class = "0x000100";
      FastConnectable = true;
    };
  };

  # write a docker image runner

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;

  virtualisation.docker = { enable = true; };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Antivirus
  services.clamav = {
    scanner.enable = true;
    daemon.enable = true;
    updater.enable = true;
  };
}
