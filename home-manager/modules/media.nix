{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    digikam
    krita
    obs-studio
    # blender
    # inkscape-with-extensions
  ];
}
