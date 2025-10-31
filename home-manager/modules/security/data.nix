{ pkgs, lib, ... }:
let
  desiredDataSecurityPackages =
    [ ] ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [ pkgs.cryptomator ];
in
{
  home.packages = desiredDataSecurityPackages;
}
