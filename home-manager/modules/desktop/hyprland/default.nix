let
  style = import ../../../../constants/style.nix;
in
{
  imports = [
    ./eww.nix
    ./hypridle.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./swaync.nix
    ./themesHypr.nix
    ./waybar.nix
    ./wlogout.nix
    ./wofi.nix
  ];

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = style.background;
      wallpaper = ", ${style.background}";
    };
  };

}
