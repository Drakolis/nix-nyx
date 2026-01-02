{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.drakolis.desktop;
  hasKde = builtins.elem "kde" cfg.types;

  debugDM = {
    ly = {
      enable = true;
    };
  };

  sddmCatppuccin = {
    sddm = {
      enable = true;
      theme = "catppuccin-mocha-mauve";
      wayland.enable = true;
    };
  };

  sddmKde = {
    sddm = {
      enable = true;
    };
  };
in
with lib;
{
  config = mkIf (cfg.enable) {
    services.displayManager = if (hasKde) then sddmKde else debugDM;

    environment.systemPackages =
      if (hasKde) then
        [ ]
      else
        [
          # SDDM
          pkgs.nerd-fonts.ubuntu
          (pkgs.catppuccin-sddm.override {
            flavor = "mocha";
            font = "Ubuntu Nerd Font";
            fontSize = "14";
            # background = "${~/.background}";
            loginBackground = true;
          })
        ];
  };
}
