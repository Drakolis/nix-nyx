let
  style = import ../../../../constants/style.nix;
in
{
  imports = [
    ./niri.nix

    ../shared/hypridle.nix
    ../shared/hyprlock.nix
    ../shared/fuzzel.nix
    ../shared/swaync.nix
    # ../shared/themes.nix
    ../shared/terminals.nix
    ../shared/waybar.nix
    ../shared/walker.nix
    ../shared/wlogout.nix
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
      ];
    };
  };
}
