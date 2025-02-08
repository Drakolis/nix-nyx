{ pkgs, ... }:
let style = import ../../constants/style.nix;
in {
  imports = [ ./hyprland.nix ./hypridle.nix ./hyprlock.nix ];

  home.pointerCursor = {
    package =
      pkgs.catppuccin-cursors.mochaDark; # For some reason this is mandatory to repeat here
    name = style.cursorTheme.name;
    size = style.cursorTheme.size;
    hyprcursor = { enable = true; }; # Here because of hyprcursor
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = style.background;
      wallpaper = ", ${style.background}";
    };
  };

}
