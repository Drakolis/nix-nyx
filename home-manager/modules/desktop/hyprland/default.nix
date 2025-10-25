let
  style = import ../../../../constants/style.nix;
in
{
  imports = [
    ./hypridle.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./fuzzel.nix
    ./swaync.nix
    ./themes.nix
    ./terminals.nix
    ./waybar.nix
    ./walker.nix
    ./wlogout.nix
    ./wofi.nix

    ./niri.nix
  ];

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = style.background;
      wallpaper = ", ${style.background}";
    };
  };
}
