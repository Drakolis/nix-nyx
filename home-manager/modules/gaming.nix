{
  config,
  lib,
  pkgs,
  ...
}:
let
  style = import ../../share/constants/style.nix;
  cfg = config.drakolis.showoff;
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
    programs.mangohud = {
      enable = true;
    };
  };
}
