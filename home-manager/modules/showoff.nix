{ config, lib, pkgs, ... }: {
  home.packages = with pkgs; [ lolcat ];

  programs.hyfetch = {
    enable = true;
    settings = {
      preset = "transgender";
      mode = "rgb";
      light_dark = "dark";
      lightness = 0.65;
      color_align = {
        mode = "horizontal";
        custom_colors = [ ];
        fore_back = null;
      };
      backend = "neofetch";
      args = null;
      distro = null;
      pride_month_shown = [ ];
      pride_month_disable = false;
    };
  };

  programs.cava = {
    enable = true;
    settings = { };
  };
}
