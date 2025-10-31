{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.drakolis.desktop;
  desktopTypes = lib.types.enum [
    "kde"
    "hyprland"
    "niri"
  ];
in
with lib;
{
  options = {
    drakolis.desktop = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enable desktop on this machine.
        '';
      };
      types = mkOption {
        default = [ "niri" ];
        type = types.listOf desktopTypes;
        description = ''
          Select the desktop to use.
        '';
      };
    };
  };
  imports = [
    ./niri.nix
    ./hyprland.nix
    ./kde.nix
  ];
  config = mkIf (cfg.enable) {
    # Things we assume are necessary for any desktop session
    services.gvfs.enable = true; # Virtual filesystem support

    xdg.terminal-exec.enable = true;

    # Wayland
    environment.sessionVariables = {
      NIXOS_OZONE_WL = 1;
    };
  };
}
