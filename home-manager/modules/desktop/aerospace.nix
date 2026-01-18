{ pkgs, ... }:
let
  style = import ../../../share/constants/style.nix;
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
in
{
  programs.aerospace = {
    enable = isDarwin;
    launchd.enable = true;
    settings = {
      config-version = 2;
      start-at-login = true;
      enable-normalization-flatten-containers = true;
      enable-normalization-opposite-orientation-for-nested-containers = true;
      accordion-padding = 30;
      default-root-container-layout = "tiles";
      default-root-container-orientation = "auto";
      on-focused-monitor-changed = [ "move-mouse monitor-lazy-center" ];
      automatically-unhide-macos-hidden-apps = true;

      persistent-workspaces = [
        "1"
        "2"
        "3"
        "4"
        "5"
        "6"
        "7"
        "8"
        "9"
        "10"
      ];

      on-mode-changed = [ ];
      key-mapping.preset = "qwerty";

      gaps = {
        inner.horizontal = style.gaps.outer;
        inner.vertical = style.gaps.outer;
        outer.left = style.gaps.outer;
        outer.bottom = style.gaps.outer;
        outer.top = style.gaps.outer;
        outer.right = style.gaps.outer;
      };

      mode = {
        main.binding = {
          alt-slash = "layout tiles horizontal vertical";
          alt-comma = "layout accordion horizontal vertical";
          alt-h = "focus left";
          alt-j = "focus down";
          alt-k = "focus up";
          alt-l = "focus right";
          alt-shift-h = "move left";
          alt-shift-j = "move down";
          alt-shift-k = "move up";
          alt-shift-l = "move right";

          alt-tab = "workspace-back-and-forth";
          alt-shift-tab = "move-workspace-to-monitor --wrap-around next";
          alt-z = "focus-back-and-forth";

          alt-n = "focus-monitor next";
          alt-p = "focus-monitor prev";
          alt-f = "fullscreen";
          alt-leftSquareBracket = "join-with left";
          alt-rightSquareBracket = "join-with right";
          alt-v = "layout floating tiling";

          alt-minus = "resize smart -50";
          alt-equal = "resize smart +50";

          alt-enter = "exec-and-forget open -n \"~/Applications/Home Manager Trampolines/Rio.app\"";
          alt-1 = "workspace 1";
          alt-2 = "workspace 2";
          alt-3 = "workspace 3";
          alt-4 = "workspace 4";
          alt-5 = "workspace 5";
          alt-6 = "workspace 6";
          alt-7 = "workspace 7";
          alt-8 = "workspace 8";
          alt-9 = "workspace 9";
          alt-0 = "workspace 10";
          alt-shift-1 = "move-node-to-workspace 1";
          alt-shift-2 = "move-node-to-workspace 2";
          alt-shift-3 = "move-node-to-workspace 3";
          alt-shift-4 = "move-node-to-workspace 4";
          alt-shift-5 = "move-node-to-workspace 5";
          alt-shift-6 = "move-node-to-workspace 6";
          alt-shift-7 = "move-node-to-workspace 7";
          alt-shift-8 = "move-node-to-workspace 8";
          alt-shift-9 = "move-node-to-workspace 9";
          alt-shift-0 = "move-node-to-workspace 10";

          alt-shift-semicolon = "mode service";
        };

        service.binding = {
          esc = [
            "reload-config"
            "mode main"
          ];
          r = [
            "flatten-workspace-tree"
            "mode main"
          ]; # reset layout
          f = [
            "layout floating tiling"
            "mode main"
          ]; # Toggle between floating and tiling layout
          backspace = [
            "close-all-windows-but-current"
            "mode main"
          ];

          # sticky is not yet supported https://github.com/nikitabobko/AeroSpace/issues/2
          #s = ["layout sticky tiling", "mode main"]

          alt-shift-h = [
            "join-with left"
            "mode main"
          ];
          alt-shift-j = [
            "join-with down"
            "mode main"
          ];
          alt-shift-k = [
            "join-with up"
            "mode main"
          ];
          alt-shift-l = [
            "join-with right"
            "mode main"
          ];
        };
      };

      workspace-to-monitor-force-assignment = {
        "10" = "secondary";
      };
    };
  };
  services.jankyborders = {
    enable = isDarwin;
    settings = {
      style = "round";
      width = style.border.outer.width;
      hidpi = "on";
      active_color = "0xff${style.colors.primary}";
      inactive_color = "0xff${style.colors.panel}";
    };
  };
}
