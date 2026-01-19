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
    ./applications/minimal.nix
  ];
  config = mkIf (cfg.enable && hasNiri) {
    programs.niri.enable = true;
    services.gnome.gnome-keyring.enable = true;

    environment.systemPackages = with pkgs; [
      # Wayland utils
      xwayland-satellite
      wl-mirror

      brightnessctl
      playerctl
      libnotify

      hypridle
      hyprlock
      hyprpaper
      hyprpicker
    ];
  };

  services.niri-session-manager = {
    enable = true;
    settings = {
      save-interval = 30;
      max-backup-count = 3;
      single_instance_apps = {
        apps = [
          "firefox"
          "zen"
          "codium"
        ];
      };

      # Applications to skip during startup
      skip_apps = {
        apps = [
          "discord"
          "slack"
          "telegram-desktop"
        ];
      };
    };
  };
}
