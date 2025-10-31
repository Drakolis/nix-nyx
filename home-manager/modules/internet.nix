{ pkgs, lib, ... }:
let
  desiredInternetPackages = [
  ]
  ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [
    pkgs.signal-desktop-bin
  ];
in
{
  home.packages = desiredInternetPackages;
}
