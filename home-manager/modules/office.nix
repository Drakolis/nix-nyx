{ pkgs, lib, ... }:
let
  desiredOfficePackages = [
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
{
  home.packages = desiredOfficePackages;

  programs.obsidian = {
    enable = true;
    cli.enable = true;
  };

  programs.qalculate = {
    enable = pkgs.stdenv.hostPlatform.isLinux;
    package = pkgs.qalculate-gtk;
  };
}
