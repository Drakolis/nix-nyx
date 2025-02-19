{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    logseq
    (writeShellScriptBin "wttr" ''
      curl wttr.in/$1
    '')
  ];
}
