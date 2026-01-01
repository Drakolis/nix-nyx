{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.drakolis.desktop;
  hasHyprland = builtins.elem "hyprland" cfg.types;
in
with lib;
{
  imports = [
    ./dm/sddm.nix
  ];
  config = mkIf (cfg.enable && hasHyprland) {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    environment.systemPackages = with pkgs; [
      # Wayland utils
      wl-mirror

      brightnessctl
      playerctl
      libnotify

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
    ];
  };
}
