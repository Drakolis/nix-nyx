# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "WinterDragon"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  security.polkit.enable = true;
  security.polkit.debug = true;

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

    # TUI Utilities
    bat
    bottom
    lynx # Terminal Browser
    ncdu
    neovim
    yazi

    # Libraries
    exfatprogs
    fcron
    dconf
    geoclue2
    gvfs
    libinput
    librsvg
    libvirt
    xfce.tumbler # Thumbnails for Thunar

    # Linux services control
    bluez-tools
    brightnessctl
    libnotify
    playerctl

    # Spell Checking
    aspell
    aspellDicts.de
    aspellDicts.ru
    aspellDicts.pt_BR
    aspellDicts.en
    aspellDicts.en-computers

    # Security: Polkit
    polkit
    hyprpolkitagent

    # Security: Keyring
    gnome-keyring
    pinentry
    pinentry-qt

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
    wayland
    wev
    wl-clipboard
    wl-mirror
    wayvnc

    # SDDM
    kdePackages.sddm
    nerd-fonts.ubuntu
    (catppuccin-sddm.override {
      flavor = "mocha";
      font = "Ubuntu Nerd Font";
      fontSize = "14";
      background = "${/home/drakolis/.background}";
      loginBackground = true;
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
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-kde

    # Critical GUI Utilities
    backintime-qt
    dconf-editor
    firefox
    imv
    kitty
    lxqt.lxqt-archiver
    pcmanfm-qt
  ];

  environment.sessionVariables = { TERMINAL = "kitty"; };

  # hardware.graphics.enable = true;
  # hardware.graphics.enable32Bit = true;

  services.displayManager = {
    sddm = {
      enable = true;
      theme = "catppuccin-mocha";
      wayland.enable = true;
    };
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Important to make KDE Partition Manager work
  programs.partition-manager.enable = true;

  # List services that you want to enable:

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.gnome.gnome-keyring.enable = true;

  services.clamav.daemon.enable = true;
  services.clamav.updater.enable = true;

  services.gvfs.enable = true;
  services.tumbler.enable = true; # Thumbnail support for images
  services.geoclue2.enable = true;

  programs.gdk-pixbuf.modulePackages = [ pkgs.librsvg ];

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
