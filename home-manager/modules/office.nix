{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    appflowy
    (writeShellScriptBin "wttr" ''
      curl wttr.in/$1
    '')
  ];

}
