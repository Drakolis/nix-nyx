{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.drakolis.input;

  hasGamepad = cfg.hasGamepad;
  hasVial = cfg.hasVial;
  hasLogitech = cfg.hasLogitech;
  hasWooting = cfg.hasWooting;
in
with lib;
{
  options = {
    drakolis.input = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enable extra input configuration.
        '';
      };

      hasGamepad = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enable Xbox gamepad support for this system.
        '';
      };

      hasVial = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enable Vial configuration software.
        '';
      };

      hasLogitech = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enable Logitech configuration software.
        '';
      };

      hasWooting = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enable Wooting configuration software.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages =
      with pkgs;
      [ piper ]
      ++ lib.optionals hasVial [
        vial
      ]
      ++ lib.optionals hasLogitech [
        solaar
      ]
      ++ lib.optionals hasLogitech [
        wootility
      ];

    # Hardware settings
    services.ratbagd.enable = true; # Gaming mouse configuration\
    hardware.xpadneo.enable = hasGamepad;
    services.udev.packages =
      with pkgs;
      [ ]
      ++ lib.optionals hasVial [
        vial
        via
      ];
    hardware.wooting.enable = hasWooting;
  };
}
