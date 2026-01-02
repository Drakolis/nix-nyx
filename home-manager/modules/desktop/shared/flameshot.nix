{ pkgs, ... }:
{
  home.packages = [
    pkgs.flameshot
  ];

  services.flameshot = {
    enable = true;
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
