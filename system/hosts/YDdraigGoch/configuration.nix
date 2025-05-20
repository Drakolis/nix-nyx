{
  lib,
  config,
  pkgs,
  ...
}:
{
  nixpkgs.config.rocmSupport = true;
  hardware.graphics.extraPackages = with pkgs; [
    pocl
    rocmPackages.clr.icd
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "YDdraigGoch"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  security.polkit.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  boot.loader.systemd-boot.configurationLimit = 5;

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

  security = {
    protectKernelImage = true; # Prevent kernel image tampering
    auditd.enable = true;
    audit.enable = true;

    sudo = {
      execWheelOnly = true; # Only allow wheel group to run sudo
      extraConfig = ''
        Defaults timestamp_timeout=30
      '';
    };
  };

  environment.etc."issue".text = ''
    \n (\l), \S Linux Kernel \r \m
    Unauthorized access to this system is prohibited.
    All activity on this system is logged and monitored.
    Unauthorized activities will be reported to the appropriate authorities.
  '';

  hardware.bluetooth.settings.General.Enable = "Source,Sink,Media,Socket"; # Restrict profiles

  services.journald.extraConfig = ''
    Storage=persistent
    SystemMaxUse=1G  # Limit log size
  '';

  services.fwupd.enable = true;

  users.users.drakolis = {
    isNormalUser = true;
    description = "Mika Drakolis";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      kdePackages.marknote

      protonmail-bridge-gui
      protonvpn-gui
      protonvpn-cli
      proton-pass
    ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHprzvwXWrzuA8qWXNGjAhWw3w297XzLMckgWiiSLu1N"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFpvdctXVRoijDWhYa4BTX33+JfFE0a3+9+tkaB4Szup"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJUpNcUS4NNyE+yDz/npwhZojZcH17Hybtc95aWbkA4i"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJaNfEcfSnRGQF4k4PWtFhPEME2Ao9QWTyhu/w+/ftgb"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILrwMCLeZhbuep6a0BHGJe3DLY5KzVQ6ylwvd1Rjv/T/"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOLXFwVqF0t+J5J1pN4To05Ddtmyd7DBbvHTdoXAC8fw"
    ];
  };

  users.users.lilyo = {
    isNormalUser = true;
    description = "Lily Oliveira";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [ ];
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

    # Wayland utils
    wev
    wl-clipboard
    wayvnc

    # Media
    kdePackages.dragon
    kdePackages.kasts
    haruna

    # Communication
    kdePackages.falkon
    kdePackages.konversation
    kdePackages.krdc
    kdePackages.krfb
    kdePackages.neochat

    # Downloading
    kdePackages.kget
    kdePackages.ktorrent

    # Office
    kdePackages.akregator
    kdePackages.kdepim-addons
    kdePackages.kweather
    kdePackages.zanshin
    libreoffice

    # Tech tools
    kdePackages.isoimagewriter
    kdePackages.kate
    kdePackages.yakuake
    podman-compose

    # File management
    kdePackages.filelight
    kdePackages.kompare
    krename

    # Configuration
    qpwgraph

    # Utilities
    kdePackages.kcalc
    kdePackages.kcharselect
    kdePackages.kcolorchooser
    kdePackages.ksystemlog
    kdePackages.sweeper
    crow-translate

    # Security
    kdePackages.kleopatra
    keepassxc
    wireshark

    # Backups
    fcron
    backintime-qt
  ];

  nixpkgs.config.permittedInsecurePackages = [ "olm-3.2.16" ];

  drakolis.gaming.enable = true;
  drakolis.geolocation.enable = true;

  drakolis.ki.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = 1;
  };

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    defaultShared = false;
    extraConf = ''
      <Location />
        Order deny,allow
        Deny from all
        Allow from 127.0.0.1
      </Location>
    '';
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
  programs.kclock.enable = true;
  programs.kde-pim.enable = true;
  programs.kde-pim.kmail = true;
  programs.kde-pim.kontact = true;
  programs.kdeconnect.enable = true;

  services.gvfs.enable = true; # Virtual filesystem support
  services.fcron.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ ]; # Explicitly allow only needed ports
    allowedUDPPorts = [ ];
    logRefusedConnections = false; # Reduce log noise (set to true if debugging)
  };

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };

  programs.mosh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
