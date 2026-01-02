{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.drakolis.power;
in
with lib;
{
  options = {
    drakolis.power = {
      enable = mkOption {
        default = true;
        type = types.bool;
        description = ''
          Enable power management tools and settings.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      acpi
      powertop
    ];

    services.upower = {
      usePercentageForPolicy = true;
      percentageLow = 15;
      percentageCritical = 5;
      percentageAction = 2;
      criticalPowerAction = "HybridSleep";
      enable = true;
    };

    services.power-profiles-daemon.enable = true;
  };
}
