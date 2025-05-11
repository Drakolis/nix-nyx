{ pkgs, lib, ... }:
let
  desiredOfficePackages =
    [
      pkgs.appflowy
      (pkgs.writeShellScriptBin "wttr" ''
        curl wttr.in/$1
      '')
    ]
    ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [
    ]
    ++ lib.optionals pkgs.stdenv.hostPlatform.isDarwin [
      pkgs.maccy
      pkgs.numi
    ];
in
with lib;
{
  home.packages = desiredOfficePackages;
}
