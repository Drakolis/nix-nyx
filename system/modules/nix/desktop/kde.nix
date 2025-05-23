{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.drakolis.desktop;
in
with lib;
{
  config = mkIf (cfg.enable && cfg.type == "kde") {
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;

    # Wayland
    environment.sessionVariables = {
      NIXOS_OZONE_WL = 1;
    };

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
      kdePackages.kweather
      kdePackages.zanshin
      libreoffice

      # Tech tools
      kdePackages.kate
      kdePackages.yakuake

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
      backintime-qt
    ];

    programs.partition-manager.enable = true;
    programs.kclock.enable = true;
    programs.kde-pim.enable = true;
    programs.kde-pim.kmail = true;
    programs.kde-pim.kontact = true;
    programs.kdeconnect.enable = true;
  };
}
