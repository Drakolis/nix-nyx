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

  security.polkit.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # HARDENING

  system.autoUpgrade = {
    enable = true;
    dates = "weekly";
    allowReboot = true;
    rebootWindow = {
      lower = "01:00";
      upper = "05:00";
    };
    flake = "gitlab:Drakolis/nix-nyx";
  };s

  environment.etc."issue".text = ''
    WARNING: Unauthorized access prohibited!
    All activities are logged.
  '';

  # HARDENING

  users.users.drakolis = {
    isNormalUser = true;
    description = "Mika Drakolis";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      yt-dlp

      kdePackages.dragon
      kdePackages.kasts
      kdePackages.kompare
      kdePackages.krdc
      kdePackages.krfb
      kdePackages.ktorrent
      kdePackages.kweather
      kdePackages.marknote
      kdePackages.neochat
      kdePackages.parley
      crow-translate
      haruna

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

  users.users.lilyo = {
    isNormalUser = true;
    description = "Lily Oliveira";
    extraGroups = [ "networkmanager" "wheel" ];
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

    # Backups
    fcron
    backintime-qt

    # Wayland utils
    wev
    wl-clipboard
    wayvnc

    # Connectivity
    tailscale

    # KDE Extras
    kdePackages.falkon
    kdePackages.filelight
    # kdePackages.konqueror
    kdePackages.kate
    kdePackages.kcharselect
    kdePackages.kcolorchooser
    kdePackages.kget
    kdePackages.kcalc
    kdePackages.yakuake
    kdePackages.sweeper

    kdePackages.kleopatra
    kdePackages.zanshin
    kdePackages.akregator
    kdePackages.kdepim-addons

    kdePackages.ksystemlog
    krusader
    krename
    qpwgraph
    kdePackages.isoimagewriter
    kdePackages.konversation

    vulnix
  ];

  drakolis.gaming.enable = true;
  drakolis.geolocation.enable = true;

  environment.sessionVariables = { NIXOS_OZONE_WL = 1; };

  services.tailscale.enable = true;
  services.tailscale.authKeyFile = "/run/secrets/tailscale_key";

  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;
    nativeMessagingHosts.packages =
      [ pkgs.kdePackages.plasma-browser-integration ];
    preferences = {
      "widget.use-xdg-desktop-portal.file-picker" = 1;
      "extensions.pocket.enabled" = false;
      "extensions.experiments.enabled" = true;
      "privacy.trackingprotection.enabled" = true;
    };

    policies = {
      ExtensionSettings = {
        # Proton Pass
        "78272b6fa58f4a1abaac99321d503a20@proton.me" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/proton-pass/latest.xpi";
          installation_mode = "force_installed";
        };
        # Proton VPN
        "vpn@proton.ch" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/proton-vpn-firefox-extension/latest.xpi";
          installation_mode = "force_installed";
        };
        # uBlock Origin
        "uBlock0@raymondhill.net" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        # React Dev Tools
        "@react-devtools" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/react-devtools/latest.xpi";
          installation_mode = "force_installed";
        };
        # Redux Dev Tools
        "extension@redux.devtools" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/reduxdevtools/latest.xpi";
          installation_mode = "force_installed";
        };
        # Vue.js Dev Tools
        "{5caff8cc-3d2e-4110-a88a-003cc85b3858}" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/vue-js-devtools/latest.xpi";
          installation_mode = "force_installed";
        };
        # Gesturefy
        "{506e023c-7f2b-40a3-8066-bc5deb40aebe}" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/gesturefy/latest.xpi";
          installation_mode = "force_installed";
        };
        # Plasma Integration (for KDE)
        "plasma-browser-integration@kde.org" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/plasma-integration/latest.xpi";
          installation_mode = "force_installed";
        };
        # Firefox Multi-Account Containers
        "@testpilot-containers" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/multi-account-containers/latest.xpi";
          installation_mode = "force_installed";
        };
        # Floccus (Bookmark Sync)
        "floccus@handmadeideas.org" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/floccus/latest.xpi";
          installation_mode = "force_installed";
        };
        # Dark Reader
        "addon@darkreader.org" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
          installation_mode = "force_installed";
        };
      };

      # Other recommended LibreWolf policies
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      FirefoxHome = {
        Search = true;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
      };
    };
  };

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    extraConf = ''
      <Location /admin>
        AuthType Default
        Require user @OWNER
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
