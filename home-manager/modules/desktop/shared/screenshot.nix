{ pkgs, ... }:
let
  style = import ../../../../shared/constants/style.nix;
in
{
  programs.satty = {
    enable = true;
    settings = {
      general = {
        fullscreen = true;
        corner-roundness = 12;
        initial-tool = "brush";
        output-filename = "/tmp/test-%Y-%m-%d_%H:%M:%S.png";
      };
      color-palette = {
        palette = [
          "#${style.colors.primary}"
          "#${style.colors.highlight}"
          "#${style.colors.error}"
          "#${style.colors.success}"
          "#${style.colors.warning}"
          "#${style.colors.info}"
          "#${style.colors.selection}"
        ];
      };

    };
  };

  services.flameshot = {
    enable = false;
    settings = {
      General = {

        # For Wayland (Install Grim seperately)
        useGrimAdapter = true;
        # Stops warnings for using Grim
        disabledGrimWarning = true;
      };
    };
  };
}
