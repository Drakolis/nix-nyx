{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.drakolis.desktop;
  hasKde = builtins.elem "kde" cfg.types;
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
      wayvnc

      # Media
      haruna
      kdePackages.kasts

      # Communication
      kdePackages.falkon
      kdePackages.konversation
      kdePackages.krdc
      kdePackages.krfb
      # kdePackages.neochat

      # Office
      kdePackages.akregator
      kdePackages.kdepim-addons
      libreoffice

      # Tech tools
      kdePackages.kate
      kdePackages.yakuake

      # File management
      kdePackages.filelight
      kdePackages.kompare
      kdePackages.kfind
      krename

      # Configuration
      qpwgraph

      # Downloading
      kdePackages.kget
      kdePackages.ktorrent

      # Utilities
      kdePackages.kcalc
      kdePackages.kcharselect
      kdePackages.kcolorchooser
      kdePackages.sweeper
      crow-translate

      # Security
      kdePackages.kleopatra
      keepassxc
      wireshark

      # Backups
      backintime-qt
    ];

    programs.partition-manager.enable = true;
    programs.kclock.enable = false;
    programs.kde-pim.enable = true;
    programs.kde-pim.kmail = true;
    programs.kde-pim.kontact = false;
    programs.kde-pim.merkuro = true;
    programs.kdeconnect.enable = true;
  };
}
