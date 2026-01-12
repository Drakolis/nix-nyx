{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.drakolis.gaming;
in
with lib;
{
  options = {
    drakolis.gaming = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enable gaming support tools.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.mangojuice ];

    programs.mangohud = {
      settingsPerApplication = {
        mpv = {
          no_display = true;
        };
      };
      enable = true;
    };
  };
}
