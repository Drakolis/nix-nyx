{ pkgs, lib, ... }:
let
  desiredInternetPackages =
    [
    ]
    ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [
      pkgs.signal-desktop-bin
    ];
in
with lib;
{
  home.packages = desiredInternetPackages;
}
