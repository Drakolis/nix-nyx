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
}
