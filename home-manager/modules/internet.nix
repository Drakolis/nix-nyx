{ pkgs, lib, ... }:
let
  desiredInternetPackages =
    [
      pkgs.element-desktop
    ]
    ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [
      pkgs.signal-desktop-bin
    ];
in
with lib;
{
  home.packages = desiredInternetPackages;
}
