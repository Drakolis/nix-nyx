{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.drakolis.dos;
in
with lib;
{
  options = {
    drakolis.dos = {
      enable = mkOption {
        default = true;
        type = types.bool;
        description = ''
          Install dosbox.
        '';
      };
    };
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      dosbox
    ];
  };
}
