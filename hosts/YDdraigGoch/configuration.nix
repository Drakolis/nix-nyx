# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "YDdraigGoch"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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

  hardware.xpadneo.enable = true;

  security.polkit.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.drakolis = {
    isNormalUser = true;
    description = "Mika Drakolis";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      # kdePackages.kamoso
      kdePackages.kweather
      kdePackages.neochat
      kdePackages.koko
      kdePackages.kasts
      kdePackages.zanshin
      kdePackages.calligra
      kdePackages.ktorrent
      kdePackages.kompare
      kdePackages.filelight
      kdePackages.dragon

      crow-translate
      qalculate-qt

      # kdePackages.marknote
      # kdePackages.klevernotes

      # kdePackages.alpaka

      kdePackages.krfb
      kdePackages.krdc

      # Games
      # kdePackages.kmahjongg
      # kdePackages.kpat

      protonmail-bridge-gui
      protonmail-desktop
      protonvpn-gui
      protonvpn-cli
      proton-pass
    ];
    shell = pkgs.zsh;
  };

  nixpkgs.config.permittedInsecurePackages = [ "olm-3.2.16" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # File system support
    exfatprogs
    apfsprogs
    ntfs3g

    # Spell Checking
    aspell
    aspellDicts.de
    aspellDicts.ru
    aspellDicts.pt_BR
    aspellDicts.en
    aspellDicts.en-computers

    # Nix Specific
    home-manager

    # XDG extras
    xdg-terminal-exec

    # Appimage support
    appimage-run

    # Backups
    fcron
    backintime-qt

    # Wayland utils
    wev
    wl-clipboard
    wayvnc

    # KDE Extras
    kdePackages.kate
    kdePackages.kcharselect
    kdePackages.kcolorchooser
    kdePackages.kgpg
    kdePackages.kalk
    qpwgraph
  ];

  programs.ladybird.enable = true;
  programs.firefox = {
    enable = true;
    nativeMessagingHosts.packages =
      [ pkgs.kdePackages.plasma-browser-integration ];
    preferences = { "widget.use-xdg-desktop-portal.file-picker" = 1; };
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  # services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
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

  programs.ryzen-monitor-ng.enable = true;

  # Important to make KDE Partition Manager work
  programs.partition-manager.enable = true;
  programs.kclock.enable = true;
  programs.kde-pim.kmail = true;
  programs.kde-pim.merkuro = true;
  programs.kdeconnect.enable = true;

  services.ntfy-sh = {
    enable = true;
    settings = {
      listen-http = ":1702";
      base-url = "http://ntfy.drakolis.com";
    };
  };

  # List services that you want to enable:

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.clamav.scanner.enable = true; # Antivirus
  services.clamav.daemon.enable = true;
  services.clamav.updater.enable = true;

  services.gvfs.enable = true; # Virtual filesystem support
  services.fcron.enable = true;

  services.avahi.enable = true; # Connects to other devices on the network

  # Geolocation, needs avahi to ask phones to share location
  services.geoclue2.enable = true;
  # services.geoclue2.enableNmea = false;
  location.provider = "geoclue2";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
