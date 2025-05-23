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
      type = mkOption {
        default = "kde";
        type = desktopTypes;
        description = ''
          Select the desktop to use.
        '';
      };
    };
  };
  imports = [
    ./hyprland.nix
    ./kde.nix
  ];
  config = mkIf (cfg.enable) {
    # Things we assume are necessary for any desktop session
    services.gvfs.enable = true; # Virtual filesystem support

    environment.systemPackages = with pkgs; [
      # XDG extras
      xdg-terminal-exec
    ];
  };
}
