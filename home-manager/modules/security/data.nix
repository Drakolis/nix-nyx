{ pkgs, lib, ... }:
let
  desiredDataSecurityPackages =
    [ ]
    ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [ pkgs.cryptomator ];
in
with lib;
{
  home.packages = desiredDataSecurityPackages;
}
