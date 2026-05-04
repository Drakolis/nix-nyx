{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wvkbd
    smile
  ];

  services.wl-clip-persist.enable = true;

  programs.imv = {
    enable = true;
    settings = {
      options.background = "181825";
      options.overlay_text_color = "cdd6f4";
      options.overlay_background_color = "11111b";
    };
  };
}
