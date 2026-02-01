let
  style = import ../../../../shared/constants/style.nix;
in
{
  imports = [
    ./hyprland.nix

    ../shared/hypridle.nix
    ../shared/hyprlock.nix

    ../shared/swaync.nix
    ../shared/themes.nix

    ../shared/waybar.nix
    ../shared/wlogout.nix

    ../shared/walker.nix
    ../shared/anyrun.nix
    ../shared/fuzzel.nix
    ../shared/wofi.nix
    ../shared/yofi.nix
  ];

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = style.background;
      wallpaper = [
        ", ${style.background}"
        "DP-2, ${style.background}"
        "HDMI-A-2, ${style.background}"
      ];
    };
  };
}
