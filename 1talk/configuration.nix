# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "YDdraigGoch"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
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

  hardware.xpadneo.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
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

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  # Vial/Via support
  services.udev.packages = with pkgs; [
    vial
    via
  ];

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
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  security.polkit.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.drakolis = {
    isNormalUser = true;
    description = "Mika Drakolis";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
#         kdePackages.kamoso
        kdePackages.kweather
        kdePackages.kclock
        kdePackages.neochat
        kdePackages.koko
        kdePackages.kdeconnect-kde
        kdePackages.kasts
        kdePackages.zanshin
        kdePackages.kmail
        kdePackages.kmail-account-wizard
        kdePackages.merkuro
        kdePackages.calligra
        kdePackages.ktorrent
        kdePackages.kompare
        kdePackages.filelight

        kdePackages.dragon

        crow-translate

#         kdePackages.marknote
#         kdePackages.klevernotes

#         kdePackages.alpaka

        kdePackages.krfb
        kdePackages.krdc

        # Games
#         kdePackages.kmahjongg
#         kdePackages.kpat

        protonmail-bridge-gui
        protonmail-desktop
        protonvpn-gui
        protonvpn-cli
        proton-pass
    ];
    shell = pkgs.zsh;
  };

  nixpkgs.config.permittedInsecurePackages = [
    "olm-3.2.16"
  ];

  # Install firefox.
  programs.firefox.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Shell
    eza
    fzf
    zsh

    clamav
    curl
    duf # Disk usage
    entr # Reload when files change
    fd # File search
    ffmpeg
    git
    gnupg
    jq # JSON parsing
    lynis # Security audit
    ripgrep
    rsync
    smartmontools
    sops
    wget

    # Libraries
    gvfs
    exfatprogs
    ntfs3g
    fcron

    # TUI Utilities
    bat
    bottom
    lynx # Terminal Browser
    neovim
    ncdu
    neovim
    yazi

    # Linux services
    geoclue2

    # Servers
    ntfy-sh

    # Spell Checking
    aspell
    aspellDicts.de
    aspellDicts.ru
    aspellDicts.pt_BR
    aspellDicts.en
    aspellDicts.en-computers
    aspellDicts.en-science

    # Nix Specific
    home-manager
    nixd
    nixfmt-classic
    nix-tree
    nixos-generators
    nixos-option

    # Other packages
    flatpak
    appimage-run

    # Wayland
    wev
    wl-clipboard
    wayvnc

    # XDG
    xdg-terminal-exec

    # nerd-fonts.ubuntu

    vial
    backintime-qt
    kdePackages.kate
    kdePackages.kcharselect
    kdePackages.kgpg
    kdePackages.kcolorchooser
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "aspell-dict-en-science" # Hillariously, the scientific jargon dictionary is not free :(
  ];

  programs.zsh.enable = true;
  programs.partition-manager.enable = true;

  services.ntfy-sh = {
    enable = true;
    settings = {
      listen-http = ":1702";
      base-url = "http://ntfy.drakolis.com";
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;


  services.clamav.daemon.enable = true;
  services.clamav.updater.enable = true;

  services.gvfs.enable = true;
  services.fcron.enable = true;

  services.flatpak.enable = true;

#   systemd.services.flatpak-repo = {
#     wantedBy = [ "multi-user.target" ];
#     path = [ pkgs.flatpak ];
#     script = ''
#       flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
#     '';
#   };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
