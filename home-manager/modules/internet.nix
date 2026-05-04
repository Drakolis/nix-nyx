{ pkgs, ... }:
let
  desiredInternetPackages = with pkgs; [
    iamb
    fractal
  ];
in
{
  home.packages = desiredInternetPackages;
  programs.element-desktop.enable = true;

}
