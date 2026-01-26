{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.drakolis.desktop;
  hasKde = builtins.elem "kde" cfg.types;
in
with lib;
{
  imports = [
    ./dm/sddm.nix
    ./applications/kde.nix
  ];
  config = mkIf (cfg.enable && hasKde) {
    services.desktopManager.plasma6.enable = true;
  };
}
