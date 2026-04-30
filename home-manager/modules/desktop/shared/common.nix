{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wvkbd
    smile
  ];

  services.wl-clip-persist.enable = true;

  programs.imv.settings = {
    enable = true;
    settings = {
      options.background = "1e1e2e";
      options.overlay_text_color = "cdd6f4";
      options.overlay_background_color = "11111b";
    };
  };

  programs.qalculate = {
    enable = true;
    package = pkgs.qalculate-gtk;
  };
}
