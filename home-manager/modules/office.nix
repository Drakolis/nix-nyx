{ pkgs, ... }:
{
  home.packages = with pkgs; [
    appflowy
    obsidian
    (writeShellScriptBin "wttr" ''
      curl wttr.in/$1
    '')
  ];

}
