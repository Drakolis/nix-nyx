{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.drakolis.desktop;
  hasNiri = builtins.elem "niri" cfg.types;
in
with lib;
{
  imports = [
    ./dm/sddm.nix
  ];
  config = mkIf (cfg.enable && hasNiri) {
    programs.niri.enable = true;
    services.gnome.gnome-keyring.enable = false; # I like KWallet

    environment.sessionVariables = {
      TERMINAL = "kitty";
    };

    environment.systemPackages = with pkgs; [
      # Wayland utils
      wev
      wl-clipboard
      wl-mirror
      wayvnc

      brightnessctl
      playerctl
      libnotify

      hypridle
      hyprlock
      hyprpaper
      hyprpicker

      # Media
      imv
      mpv
      haruna

      # Office
      libreoffice

      # Tech tools
      kitty

      # File management
      pcmanfm-qt
      lxqt.lxqt-archiver
      kdePackages.filelight
      kdePackages.kompare
      krename

      # System
      lxqt.qps
      lxqt.pavucontrol-qt
      qpwgraph

      # Utilities
      kdePackages.kcalc
      kdePackages.kcharselect
      kdePackages.kcolorchooser
      crow-translate
      # caffeine-ng

      # Security
      kdePackages.kgpg
      keepassxc
      kdePackages.kwallet
      kdePackages.kwalletmanager

      # Backups
      backintime-qt
    ];

    programs.partition-manager.enable = true;
    programs.kde-pim.enable = true;
    programs.kde-pim.kmail = true;
    programs.kde-pim.kontact = false;
    programs.kde-pim.merkuro = true;
  };
}
