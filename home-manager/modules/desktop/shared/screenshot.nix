{ pkgs, ... }:
{
  home.packages = [
    pkgs.satty
  ];

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
