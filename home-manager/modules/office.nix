{ pkgs, lib, ... }:
let
  desiredOfficePackages = [
    pkgs.obsidian
    (pkgs.writeShellScriptBin "wttr" ''
      curl wttr.in/$1
    '')
  ]
  ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [
    pkgs.kdePackages.okular
  ]
  ++ lib.optionals pkgs.stdenv.hostPlatform.isDarwin [
    pkgs.maccy
    pkgs.numi
  ];
in
{
  home.packages = desiredOfficePackages;
}
