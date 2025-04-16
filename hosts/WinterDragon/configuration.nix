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

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  users.users.drakolis = {
    isNormalUser = true;
    description = "Mika Drakolis";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      yt-dlp

      element-desktop

      libreoffice

      protonmail-bridge-gui
      protonmail-desktop
      protonvpn-gui
      protonvpn-cli
      proton-pass

      mullvad-browser
    ];
    shell = pkgs.zsh;
  };

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
    xdg-desktop-portal-hyprland
    lxqt.xdg-desktop-portal-lxqt

    # SDDM
    kdePackages.sddm
    nerd-fonts.ubuntu
    (catppuccin-sddm.override {
      flavor = "mocha";
      font = "Ubuntu Nerd Font";
      fontSize = "14";
      # background = "${~/.background}";
      loginBackground = true;
    })

    # Wayland
    wayland
    wev
    wl-clipboard
    wl-mirror
    wayvnc

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

    # Libraries
    dconf
    librsvg
    xfce.tumbler # Thumbnails for Thunar

    # Linux services control
    bluez-tools
    brightnessctl
    libnotify
    playerctl

    # Security
    polkit
    hyprpolkitagent
    keepassxc
    pinentry
    pinentry-qt

    # Critical GUI Utilities
    backintime-qt
    dconf-editor
    imv
    kitty
    pcmanfm-qt
    lxqt.lxqt-archiver
    lxqt.qps
    lxqt.pavucontrol-qt
    qpwgraph
  ];

  drakolis.fonts.fontSet = "ubuntu";
  drakolis.geolocation.enable = true;

  environment.sessionVariables = {
    TERMINAL = "kitty";
    NIXOS_OZONE_WL = 1;
  };

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

  programs.wireshark.enable = true;
  programs.partition-manager.enable = true;

  services.gvfs.enable = true;
  services.fcron.enable = true;

  services.tumbler.enable = true; # Thumbnail support for images
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
