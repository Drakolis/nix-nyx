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

      kdePackages.kwallet
      kdePackages.kwalletmanager
    ];
  };
}
