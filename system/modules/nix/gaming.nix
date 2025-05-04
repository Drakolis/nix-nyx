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
        type = with types; bool;
        description = ''
          Enable gaming setup on this machine.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    hardware.xpadneo.enable = true;

    environment.systemPackages = with pkgs; [
      dosbox
      mangohud
      piper
    ];

    services.ratbagd.enable = true; # Gaming mouse configuration
    programs.gamemode.enable = true;
  };
}
