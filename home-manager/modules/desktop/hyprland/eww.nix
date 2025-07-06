{ pkgs, ... }:
{
  home.packages = with pkgs; [
    eww
    hyprland-activewindow
    hyprland-workspaces
  ];
}
