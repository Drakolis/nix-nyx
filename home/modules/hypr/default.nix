{ pkgs, ... }:
let style = import ../../constants/style.nix;
in {
  imports = [ ./hyprland.nix ./hypridle.nix ./hyprlock.nix ];

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = style.background;
      wallpaper = ", ${style.background}";
    };
  };

}
