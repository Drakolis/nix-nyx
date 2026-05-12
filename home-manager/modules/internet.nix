{ pkgs, ... }:
let
  desiredInternetPackages =
    with pkgs;
    [
      iamb
    ]
    ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [
      fractal
    ];
in
{
  home.packages = desiredInternetPackages;
  programs.element-desktop.enable = true;

}
