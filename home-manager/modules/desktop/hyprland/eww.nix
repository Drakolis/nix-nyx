{ pkgs, ... }:
{
  home.packages = with pkgs; [
    eww
    hyprland-activewindow
    hyprland-workspaces
    (pkgs.writers.writeJSBin "drakolis-keyboard-layout" { } (
      builtins.readFile ./scripts/drakolis-keyboard-layout.js
    ))
  ];
}
