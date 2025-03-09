{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    obsidian
    (writeShellScriptBin "wttr" ''
      curl wttr.in/$1
    '')
  ];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "obsidian" ];

}
