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
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };

    programs.gamemode = {
      settings = {
        custom = {
          start = "${pkgs.libnotify}/bin/notify-send -i gamepad 'GameMode started'";
          end = "${pkgs.libnotify}/bin/notify-send -i gamepad 'GameMode ended'";
        };
      };
      enable = true;
    };
  };
}
