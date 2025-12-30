{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.drakolis.desktop;

  hasKitty = cfg.terminal == "kitty";
  hasUndefined = cfg.terminal == "undefined";
in
with lib;
{
  config = mkIf (hasKitty) {

    environment.sessionVariables = {
      TERMINAL = "kitty";
    };
    environment.systemPackages = with pkgs; [
      kitty
    ];
  };
}
