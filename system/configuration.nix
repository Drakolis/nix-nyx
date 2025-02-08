# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "WinterDragon"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

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

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.drakolis = {
    isNormalUser = true;
    description = "Mika Drakolis";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      protonmail-bridge-gui
      protonmail-desktop
      protonvpn-gui
      protonvpn-cli
      proton-pass
    ];
    shell = pkgs.zsh;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Shell
    eza
    fzf
    zsh

    # Terminal utilities
    clamav
    ctags
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
    tokei
    wget

    # TUI Utilities
    bat
    bottom
    lynx # Terminal Browser
    ncdu
    neovim
    yazi

    # Libraries
    libinput
    librsvg
    libvirt

    # Linux services
    bluez
    dconf
    geoclue2
    gvfs
    xfce.tumbler # Thumbnails for Thunar

    # Linux services control
    bluez-tools
    brightnessctl
    libnotify
    playerctl

    # Security: Polkit
    polkit
    hyprpolkitagent

    # Security: Keyring
    gnome-keyring
    seahorse

    # Nix Specific
    home-manager
    nixd
    nixfmt-classic
    nix-tree
    nixos-generators
    nixos-option

    # Other package managers
    flatpak

    # Wayland
    wayland
    wev
    wl-clipboard
    wl-mirror
    wayvnc

    # SDDM
    sddm
    nerd-fonts.ubuntu
    (catppuccin-sddm.override {
      flavor = "mocha";
      font = "Ubuntu Nerd Font";
      fontSize = "14";
      background = "${/home/drakolis/.background}";
      loginBackground = false;
    })

    # Hyprland
    hyprland
    hyprcursor
    hypridle
    hyprlock
    hyprpaper
    hyprpicker
    hyprshade
    hyprshot
    hyprsunset

    # XDG
    xdg-terminal-exec
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland

    # Critical GUI Utilities
    clamtk
    dconf-editor
    firefox
    gparted
    imv
    kitty
    mate.engrampa
    timeshift
    xfce.thunar
    xfce.thunar-volman
  ];

  environment.sessionVariables = { TERMINAL = "kitty"; };

  programs.zsh.enable = true;

  services.displayManager.sddm = {
    enable = true;
    theme = "catppuccin-mocha";
    wayland.enable = true;
  };

  programs.hyprland = { enable = true; };

  security.polkit.enable = true;
  security.polkit.debug = true;

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot =
    true; # powers up the default Bluetooth controller on boot

  services.gvfs.enable = true;
  services.tumbler.enable = true; # Thumbnail support for images
  services.gnome.gnome-keyring.enable = true;
  services.geoclue2.enable = true;

  services.clamav.daemon.enable = true;
  services.clamav.updater.enable = true;

  programs.gdk-pixbuf.modulePackages = [ pkgs.librsvg ];

  programs.xfconf.enable = true;
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-dropbox-plugin
      thunar-media-tags-plugin
    ];
  };

  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  programs.ssh.startAgent = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

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
