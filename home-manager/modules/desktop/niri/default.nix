let
  style = import ../../../../share/constants/style.nix;
in
{
  imports = [
    ./niri.nix

    ../shared/hypridle.nix
    ../shared/hyprlock.nix

    ../shared/themes.nix

    ../shared/ignis.nix
    ../shared/xdg.nix

    ../shared/screenshot.nix

    ../shared/walker.nix
    ../shared/anyrun.nix
  ];

  services.swww.enable = true;

  services.hyprpaper = {
    enable = false;
    settings = {
      preload = style.background;
      wallpaper = [
        ", ${style.background}"
        # "DP-2, ${style.background}"
        # "HDMI-A-2, ${style.background}"
      ];
    };
  };
}
