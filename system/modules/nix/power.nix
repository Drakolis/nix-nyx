{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.drakolis.ssh;
in
with lib;
{
  options = {
    drakolis.ssh = {
      enable = mkOption {
        default = false;
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

    services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 50;

        # Optional helps save long term battery health
        START_CHARGE_THRESH_BAT0 = 0; # 40 and below it starts to charge
        STOP_CHARGE_THRESH_BAT0 = 100; # 80 and above it stops charging
        START_CHARGE_THRESH_BAT1 = 0; # 40 and below it starts to charge
        STOP_CHARGE_THRESH_BAT1 = 100; # 80 and above it stops charging

        TPSMAPI_ENABLE = 1;
      };
    };
  };
}
