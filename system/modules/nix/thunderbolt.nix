{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.drakolis.thunderbolt;
in
with lib;
{
  options = {
    drakolis.thunderbolt = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = ''
          Enable thunderbolt services on this machine.
        '';
      };
    };
  };

  config = mkIf cfg.enable {

    services.hardware.bolt.enable = true;

    environment.systemPackages = with pkgs; [
      kdePackages.plasma-thunderbolt
    ];
  };
}
