{
  imports = [
    ./niri.nix
    ./binds.nix
    ./hardware.nix
    ./window-rules.nix
    ./styling.nix

    ../shared/hypridle.nix
    ../shared/hyprlock.nix

    ../shared/themes.nix

    ../shared/ignis.nix
    ../shared/xdg.nix

    ../shared/screenshot.nix

    ../shared/walker.nix
    ../shared/anyrun.nix
  ];

  services.swww.enable = true;
}
