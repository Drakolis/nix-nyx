{ config, lib, ... }:
let
  cfg = config.drakolis.geolocation;
in
with lib;
{
  options = {
    drakolis.geolocation = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = ''
          Enable geolocation services on this machine.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    services.geoclue2 = {
      enable = true;
    };
    location.provider = "geoclue2";
  };
}
