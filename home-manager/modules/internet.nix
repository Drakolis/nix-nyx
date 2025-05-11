{ pkgs, lib, ... }:
let
  desiredInternetPackages =
    [ ]
    ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [
      pkgs.signal-desktop-bin
    ]
    ++ lib.optionals pkgs.stdenv.hostPlatform.isDarwin [
      pkgs.element-desktop
    ];
in
with lib;
{
  home.packages = desiredInternetPackages;
}
