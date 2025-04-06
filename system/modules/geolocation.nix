{ config, lib, ... }:
let cfg = config.drakolis.geolocation;
in with lib; {
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
    services.avahi.enable = true; # Connects to other devices on the network
    services.geoclue2 = {
      enable = true;
      enableNmea = true; # Needs avahi to ask phones for location
    };
    location.provider = "geoclue2";
  };
}
