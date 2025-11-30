{
  config,
  pkgs,
  lib,
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
          Enable gaming stuff.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    programs.gamemode.enable = true;
  };
}
