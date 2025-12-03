{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.drakolis.desktop;
  hasKde = builtins.elem "kde" cfg.types;

  hasAdvanced = builtins.elem "advanced" cfg.profiles;
  hasDownloads = builtins.elem "downloads" cfg.profiles;
  hasMedia = builtins.elem "media" cfg.profiles;
  hasOffice = builtins.elem "office" cfg.profiles;
  hasSecurity = builtins.elem "security" cfg.profiles;
  hasRemoteDesktop = builtins.elem "remoteDesktop" cfg.profiles;
in
with lib;
{
  imports = [
    ./dm/sddm.nix
  ];
  config = mkIf (cfg.enable && hasKde) {
    services.desktopManager.plasma6.enable = true;

    environment.systemPackages = with pkgs; [
      # Wayland utils
      wev
      wl-clipboard

      # Media
      haruna

      # Communication
      kdePackages.falkon
      kdePackages.konversation
      kdePackages.krdc
      kdePackages.neochat

      # Tech tools
      kdePackages.kate

      # File management
      kdePackages.filelight
      kdePackages.kfind
      quota

      # Configuration
      qpwgraph

      # Utilities
      kdePackages.kcalc
      kdePackages.kcharselect
      kdePackages.kcolorchooser
      kdePackages.sweeper
      crow-translate
      maliit-keyboard

      # Security
      keepassxc

      # Backups
      backintime-qt
    ]
    # Profile: Advanced
    ++ lib.optionals hasAdvanced [
      kdePackages.yakuake
      kdePackages.kompare
      krename
    ]
    # Profile: Downloads
    ++ lib.optionals hasDownloads [
      kdePackages.kget
      kdePackages.ktorrent
    ]
    # Profile: Media
    ++ lib.optionals hasMedia [
      kdePackages.kasts
    ]
    # Profile: Office
    ++ lib.optionals hasOffice [
      kdePackages.akregator
      kdePackages.kdepim-addons
      libreoffice
    ]
    # Profile: Security
    ++ lib.optionals hasSecurity [
      kdePackages.kleopatra
      wireshark
    ]
    # Profile: Remote Desktop
    ++ lib.optionals hasRemoteDesktop [
      kdePackages.krfb
      wayvnc
    ];

    nixpkgs.config.permittedInsecurePackages = [
      "olm-3.2.16"
    ];

    programs.partition-manager.enable = true;
    programs.kdeconnect.enable = true;
    programs.kclock.enable = false;
    programs.kde-pim.enable = true;
    programs.kde-pim.kmail = true;
    programs.kde-pim.kontact = false;
    programs.kde-pim.merkuro = true;
  };
}
