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
  config = mkIf (cfg.enable && cfg.type == "hyprland") {
    services.displayManager = {
      sddm = {
        enable = true;
        theme = "catppuccin-mocha-mauve";
        wayland.enable = true;
      };
    };

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    programs.niri.enable = true;
    services.gnome.gnome-keyring.enable = false;

    environment.sessionVariables = {
      TERMINAL = "kitty";
      NIXOS_OZONE_WL = 1;
    };

    environment.systemPackages = with pkgs; [
      # SDDM
      nerd-fonts.ubuntu
      (catppuccin-sddm.override {
        flavor = "mocha";
        font = "Ubuntu Nerd Font";
        fontSize = "14";
        # background = "${~/.background}";
        loginBackground = true;
      })

      # Wayland utils
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

      brightnessctl
      playerctl
      libnotify

      # Media
      imv
      mpv

      # Office
      kdePackages.akregator
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
      caffeine-ng

      # Security
      kdePackages.kgpg
      keepassxc
      kdePackages.kwallet
      kdePackages.kwalletmanager

      # Backups
      backintime-qt
    ];

    programs.partition-manager.enable = true;
  };
}
