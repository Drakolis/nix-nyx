{
  inputs,
  pkgs,
  ...
}:
{
  home.packages = [
    inputs.niri-screen-time.packages.${pkgs.stdenv.hostPlatform.system}.default
    (pkgs.writeShellScriptBin "niri-focus-or-spawn" ''
      WIN_ID=$(niri msg windows | grep -B2 "App ID: \"$1\"" | grep 'Window ID ' | grep -oE '[0-9]+')

      if [ -z "$WIN_ID" ]; then
          "$1"
      else
          niri msg action focus-window --id $WIN_ID
      fi
    '')
  ];

  programs.niri = {
    enable = true;
    package = inputs.niri-flake.packages.${pkgs.system}.niri-unstable;

    settings = {
      environment = {
        QT_QPA_PLATFORMTHEME = "qt6ct";
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
        SDL_JOYSTICK_HIDAPI = 0; # Seems to fix XBox controller not working with bluetooth on Linux
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
        slowdown = 1.5;
      };

      screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

      config-notification.disable-failed = false;

      workspaces = {
      };

      layer-rules = [ ];
    };
  };
}
