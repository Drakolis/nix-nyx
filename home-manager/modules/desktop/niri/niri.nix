{
  inputs,
  pkgs,
  ...
}:
let
  style = import ../../../../shared/constants/style.nix;
  commands = import ../../../../shared/constants/commands.nix;
in
{
  home.packages = [
    inputs.niri-screen-time.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;

    settings = {
      environment = {
        QT_QPA_PLATFORMTHEME = "qt6ct";
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
      };

      spawn-at-startup = [
        { command = [ "tailscale-systray" ]; }
        {
          argv = [
            "niri-screen-time"
            "-daemon"
          ];
        }
        {
          argv = [
            "syncthingtray"
            "--wait"
          ];
        }
        {
          argv = [
            "ignis"
            "init"
          ];
        }
      ];

      animations = {
        enable = true;
        slowdown = 2;
      };

      screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

      config-notification.disable-failed = false;

      workspaces = {
      };

      layer-rules = [ ];
    };
  };
}
