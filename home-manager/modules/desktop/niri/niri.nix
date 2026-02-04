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

      screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

      config-notification.disable-failed = false;
      clipboard.disable-primary = true;

      input = {
        power-key-handling.enable = true;
        keyboard = {
          numlock = true;
          repeat-delay = 600;
          repeat-rate = 25;
          track-layout = "window";
          xkb = {
            layout = "nz,ru";
            options = "grp:ctrl_space_toggle,compose:sclk,compose:ralt,apple:alupckeys";
          };
        };
        mouse = {
          enable = true;
          accel-speed = 0.1;
          accel-profile = "flat";
          scroll-method = null;
          natural-scroll = false;
        };
        touchpad = {
          enable = true;
          accel-speed = 0.2;
          accel-profile = "flat";
          scroll-method = "two-finger";
          natural-scroll = true;
          tap = true;
          dwt = true;
          dwtp = true;
          drag = true;
          drag-lock = false;
          click-method = "clickfinger";
          disabled-on-external-mouse = true;
        };
        trackball = {
          enable = true;
          accel-speed = 0.2;
          accel-profile = "flat";
          scroll-method = null;
          natural-scroll = false;

        };
        trackpoint = {
          enable = true;
          accel-speed = 0.2;
          accel-profile = "flat";
          natural-scroll = false;
          scroll-method = null;
        };
        warp-mouse-to-focus.enable = false;
      };

      # switch-events = {
      #   lid-close = ;
      #   lid-open = ;
      #   tablet-mode-on.action.spawn = ["gsettings" "set" "org.gnome.desktop.a11y.applications" "screen-keyboard-enabled" "true"];
      #   tablet-mode-off.action.spawn = ["gsettings" "set" "org.gnome.desktop.a11y.applications" "screen-keyboard-enabled" "false"];
      # };

      cursor = {
        hide-after-inactive-ms = 5000;
        hide-when-typing = true;
        # size = ;
        # theme = ;
      };

      outputs = {
        "eDP-1" = {
          name = "eDP-1";
          focus-at-startup = true;
          enable = true;
          mode = {
            width = 1920;
            height = 1080;
            refresh = 60.;
          };
          position = {
            x = 0;
            y = 0;
          };
          scale = 1;
          transform.rotation = 0;
        };
        "HDMI-A-2" = {
          name = "HDMI-A-2";
          enable = true;
          mode = {
            width = 2560;
            height = 1440;
            refresh = 59.951;
          };
          position = {
            x = -1920;
            y = 0;
          };
          scale = 1;
          transform.rotation = 0;
        };
        "DP-1" = {
          name = "DP-1";
          focus-at-startup = false;
          enable = true;
          mode = {
            width = 2560;
            height = 1440;
            refresh = 164.958;
          };
          position = {
            x = 2560;
            y = 0;
          };
          scale = 1;
          transform.rotation = 0;
        };
        "DP-2" = {
          name = "DP-2";
          focus-at-startup = true;
          enable = true;
          mode = {
            width = 2560;
            height = 1440;
            refresh = 143.999;
          };
          position = {
            x = 0;
            y = 0;
          };
          scale = 1;
          transform.rotation = 0;
        };
      };

      overview = {
        backdrop-color = "#${style.colors.shadow}";
      };

      prefer-no-csd = true;

      layout = {
        background-color = "#${style.colors.background}";
        border = {
          enable = true;
          width = style.border.outer.width;
          active.color = "#${style.colors.primary}";
          inactive.color = "#${style.colors.windowBorder}";
          urgent.color = "#${style.colors.warning}";
        };

        focus-ring = {
          enable = false;
          width = style.border.outer.width;
          active.color = "#${style.colors.primary}";
          inactive.color = "#${style.colors.windowBorder}";
          urgent.color = "#${style.colors.warning}";
        };

        shadow = {
          enable = true;
          draw-behind-window = false;
          inactive-color = "#${style.colors.shadow}";
          color = "#${style.colors.shadow}";
          offset = {
            x = 0;
            y = 2;
          };
          softness = 6;
          spread = 1;
        };

        insert-hint = {
          enable = true;
          display.color = "#${style.colors.shadow}";
        };

        tab-indicator = {
          enable = true;
          hide-when-single-tab = false;

          gap = 5;
          gaps-between-tabs = 0;
          place-within-column = true;
          # total-proportion = 0.5;
          width = 8;

          active.color = "#${style.colors.primary}"; # Too hard to see
          inactive.color = "#${style.colors.panel}";
          urgent.color = "#${style.colors.warning}";
        };

        preset-column-widths = [
          { proportion = 1. / 3.; }
          { proportion = 1. / 2.; } # Extract to constants
          { proportion = 2. / 3.; }

          # { fixed = 1920; }
        ];

        preset-window-heights = [
          # { proportion = 1. / 3.; }
          { proportion = 1. / 2.; }
          # { proportion = 2. / 3.; }

          # { fixed = 1080; }
        ];

        always-center-single-column = true;
        center-focused-column = "never";
        default-column-width.proportion = 1. / 2.;

        empty-workspace-above-first = false;
        gaps = style.gaps.outer;
        struts = {
          # bottom = 64;
          # left = 64;
          # right = 64;
          # top = 64;
        };
      };

      workspaces = {
      };

      window-rules = [
        {
          matches = [ { is-window-cast-target = true; } ];

          focus-ring = {
            active.color = "#${style.colors.error}";
            inactive.color = "#7d0d2d";
          };

          border = {
            inactive.color = "#7d0d2d";
          };

          shadow = {
            color = "#7d0d2d70";
            inactive-color = "#7d0d2d70";
          };

          tab-indicator = {
            active.color = "#${style.colors.error}";
            inactive.color = "#7d0d2d";
          };
        }
        {
          # Rules for windows that should clearly float, but don't
          matches = [
            {
              app-id = "engrampa";
              title = "Compress";
            }
            {
              app-id = "thunar";
              title = "^(File Operation Progress|Rename \".*\")$";
            }
            {
              title = "Select a process name...";
              app-id = "caffeine";
            }
            {
              app-id = "tvp-git-helper";
            }
            {
              app-id = "^(firefox|librewolf|zen-beta)$";
              title = "Picture-in-Picture";
            }
          ];
          open-floating = true;
        }
        {
          # Rules for windows that should not be shared
          matches = [
            { app-id = ''^org\.keepassxc\.KeePassXC$''; }
            { app-id = ''^org\.gnome\.World\.Secrets$''; }
            { app-id = ''^org\.kde\.kwalletmanager$''; }
            { app-id = "Proton Pass"; }
          ];
          block-out-from = "screen-capture";
        }
        {
          matches = [
            { app-id = "Proton Pass"; }
          ];
          open-floating = true;
          block-out-from = "screen-capture";
          default-window-height.fixed = 600;
          default-column-width.proportion = 0.45;
        }
        {
          # Rules for steam friend list to get out of the way
          matches = [
            {
              app-id = "steam";
              title = "Friends List";
            }
          ];
          open-floating = true;
          default-floating-position = {
            relative-to = "bottom-right";
            x = 0;
            y = 0;
          };
        }
        {
          matches = [
            {
              app-id = "steam";
              title = ''^notificationtoasts_\d+_desktop$'';
            }
          ];
          open-floating = true;
          open-focused = false;
          default-floating-position = {
            relative-to = "top-right";
            x = 0;
            y = 0;
          };
        }
        {
          # Rules for windows that should clearly float and also be limited in size
          matches = [
            {
              title = "^((Open|Save).*)$";
            }
            {
              app-id = "kitty";
              title = "Clipboard preview";
            }
          ];
          open-floating = true;
          default-window-height.fixed = 600;
          default-column-width.proportion = 0.45;
        }
        # GLOBAL
        {
          clip-to-geometry = true;
          geometry-corner-radius = {
            bottom-left = style.border.outer.radius + 0.0;
            bottom-right = style.border.outer.radius + 0.0;
            top-left = style.border.outer.radius + 0.0;
            top-right = style.border.outer.radius + 0.0;
          };
          opacity = 1.;
          draw-border-with-background = false;
          # open-focused = ;
          # open-fullscreen
          # open-maximized
          # open-on-output
          # open-on-workspace
          # max-height
          # max-width
          # min-height
          # min-width
          # default-floating-position.relative-to = "top-left", "top-right", "bottom-left", "bottom-right", "top", "bottom", "left", "right";
        }
      ];

      layer-rules = [ ];

      hotkey-overlay = {
        hide-not-bound = false;
        skip-at-startup = true;
      };

      binds = {
        "Mod+F1".action.show-hotkey-overlay = [ ];

        # Programs
        "Mod+Return" = {
          action.spawn = commands.terminal;
          hotkey-overlay.title = "Launch Terminal";
        };

        "Mod+Shift+Return" = {
          action.spawn = "${commands.terminalExec} zellij";
          hotkey-overlay.title = "Launch Terminal with Zellij";
        };

        "Mod+B" = {
          action.spawn = commands.gui.browser;
          hotkey-overlay.title = "Launch Browser";
        };

        "Mod+E" = {
          action.spawn-sh = "${commands.terminalExec} ${commands.tui.editor}";
          hotkey-overlay.title = "Launch Editor";
        };

        "Mod+Shift+E" = {
          action.spawn = commands.gui.editor;
          hotkey-overlay.title = "Launch GUI Editor";
        };

        "Mod+A" = {
          action.spawn-sh = "${commands.terminalExec} ${commands.tui.fileManager}";
          hotkey-overlay.title = "Launch File Manager";
        };

        "Mod+Shift+A" = {
          action.spawn = commands.gui.fileManager;
          hotkey-overlay.title = "Launch GUI File Manager";
        };

        "Mod+Space" = {
          action.spawn-sh = commands.runner;
          hotkey-overlay.title = "Application Launcher";
        };

        "Mod+F2" = {
          action.spawn-sh = "ignis toggle-window eggshell_chat_center_0";
          hotkey-overlay.title = "Shell: Notepad";
        };

        "Mod+F3" = {
          action.spawn-sh = "ignis toggle-window eggshell_info_center";
          hotkey-overlay.title = "Shell: Information Center";
        };

        "Mod+F4" = {
          action.spawn-sh = "ignis toggle-window eggshell_control_center_0";
          hotkey-overlay.title = "Shell: Control Center";
        };

        "Mod+F5" = {
          action.spawn-sh = "ignis reload";
          hotkey-overlay.title = "Reload Shell";
        };

        "Mod+Ctrl+Q" = {
          action.spawn = [
            "loginctl"
            "lock-session"
          ];
          hotkey-overlay.title = "Lock the Screen";
        };

        "Mod+Shift+Q" = {
          action.spawn = commands.shutdown;
          hotkey-overlay.title = "Shutdown menu";
        };

        # "Mod+G" = {
        #   action.spawn-sh = ''${commands.notifyHyprpicker} & hyprpicker -a'';
        #   hotkey-overlay.title = "Color picker";
        # };

        "Mod+Y" = {
          action.spawn = commands.gui.passwords;
          hotkey-overlay.title = "Launch Password Manager";
        };

        "Mod+M" = {
          action.spawn-sh = "${commands.terminal} -T=\"Clipboard preview\" -e zsh -c 'wl-paste | ${commands.previewText}'";
          hotkey-overlay.title = "Show Clipboard Preview";
        };

        # "$mainMod, K, exec, "
        # "$mainMod, N, exec, swaync-client -t"
        # "$mainMod SHIFT, N, exec, swaync-client -d"

        # Media keys
        "XF86AudioRaiseVolume" = {
          action.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ --limit 1";
          allow-when-locked = true;
        };
        "XF86AudioLowerVolume" = {
          action.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1- --limit 1";
          allow-when-locked = true;
        };
        "XF86AudioMute" = {
          action.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          allow-when-locked = true;
        };
        "XF86AudioMicMute" = {
          action.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          allow-when-locked = true;
        };
        "Shift+XF86AudioRaiseVolume" = {
          action.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 0.1+ --limit 1";
          allow-when-locked = true;
        };
        "Shift+XF86AudioLowerVolume" = {
          action.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 0.1- --limit 1";
          allow-when-locked = true;
        };
        "Shift+XF86AudioMute" = {
          action.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          allow-when-locked = true;
        };
        "XF86AudioPause" = {
          action.spawn = [
            "playerctl"
            "play-pause"
          ];
          allow-when-locked = true;
          repeat = false;
        };
        "XF86AudioPlay" = {
          action.spawn = [
            "playerctl"
            "play-pause"
          ];
          allow-when-locked = true;
          repeat = false;
        };
        "XF86AudioNext" = {
          action.spawn = [
            "playerctl"
            "next"
          ];
          allow-when-locked = true;
          repeat = false;
        };
        "XF86AudioPrev" = {
          action.spawn = [
            "playerctl"
            "previous"
          ];
          allow-when-locked = true;
          repeat = false;
        };
        "XF86MonBrightnessUp" = {
          action.spawn = [
            "brightnessctl"
            "--class=backlight"
            "set"
            "+10%"
          ];
          allow-when-locked = true;
        };
        "XF86MonBrightnessDown" = {
          action.spawn = [
            "brightnessctl"
            "--class=backlight"
            "set"
            "10%-"
          ];
          allow-when-locked = true;
        };

        # Overview
        "Mod+O" = {
          action.toggle-overview = [ ];
          repeat = false;
        };
        # Mod+Tab repeat=false { spawn "niri-switch"; }

        # Window actions
        "Mod+Q" = {
          repeat = false;
          action.close-window = [ ];
        };

        # Focus
        "Mod+Left".action.focus-column-left = [ ];
        "Mod+Right".action.focus-column-right = [ ];
        "Mod+H".action.focus-column-left = [ ];
        "Mod+L".action.focus-column-right = [ ];

        # Only focus on the same workspace
        # "Mod+Down".action.focus-window-down = [ ];
        # "Mod+Up".action.focus-window-up = [ ];
        # "Mod+J".action.focus-window-down = [ ];
        # "Mod+K".action.focus-window-up = [ ];

        "Mod+Down".action.focus-window-or-workspace-down = [ ];
        "Mod+Up".action.focus-window-or-workspace-up = [ ];
        "Mod+J".action.focus-window-or-workspace-down = [ ];
        "Mod+K".action.focus-window-or-workspace-up = [ ];

        "Mod+Z".action.focus-window-previous = [ ];

        # Position
        "Mod+Shift+Left".action.move-column-left = [ ];
        "Mod+Shift+Right".action.move-column-right = [ ];
        "Mod+Shift+H".action.move-column-left = [ ];
        "Mod+Shift+L".action.move-column-right = [ ];

        "Mod+Shift+Down".action.move-window-down-or-to-workspace-down = [ ];
        "Mod+Shift+Up".action.move-window-up-or-to-workspace-up = [ ];
        "Mod+Shift+J".action.move-window-down-or-to-workspace-down = [ ];
        "Mod+Shift+K".action.move-window-up-or-to-workspace-up = [ ];

        # Only focus on the same workspace
        # "Mod+Shift+Down".action.move-window-down = [ ];
        # "Mod+Shift+Up".action.move-window-up = [ ];
        # "Mod+Shift+J".action.move-window-down = [ ];
        # "Mod+Shift+K".action.move-window-up = [ ];

        # Column actions
        "Mod+Home".action.focus-column-first = [ ];
        "Mod+End".action.focus-column-last = [ ];
        "Mod+Ctrl+H".action.focus-column-first = [ ];
        "Mod+Ctrl+L".action.focus-column-last = [ ];
        "Mod+Shift+Home".action.move-column-to-first = [ ];
        "Mod+Shift+End".action.move-column-to-last = [ ];
        "Mod+Ctrl+Shift+H".action.move-column-to-first = [ ];
        "Mod+Ctrl+Shift+L".action.move-column-to-last = [ ];

        "Mod+Alt+H".action.focus-monitor-left = [ ];
        "Mod+Alt+L".action.focus-monitor-right = [ ];
        "Mod+Alt+Shift+H".action.move-column-to-monitor-left = [ ];
        "Mod+Alt+Shift+L".action.move-column-to-monitor-right = [ ];
        "Mod+Alt+Ctrl+Shift+H".action.move-workspace-to-monitor-left = [ ];
        "Mod+Alt+Ctrl+Shift+L".action.move-workspace-to-monitor-right = [ ];

        # Monitor actions (needs review)
        # Mod+Shift+Left  { focus-monitor-left; }
        # Mod+Shift+Down  { focus-monitor-down; }
        # Mod+Shift+Up    { focus-monitor-up; }
        # Mod+Shift+Right { focus-monitor-right; }
        # Mod+Shift+J     { focus-monitor-down; }
        # Mod+Shift+K     { focus-monitor-up; }

        # Mod+Shift+Ctrl+Left  { move-column-to-monitor-left; }
        # Mod+Shift+Ctrl+Down  { move-column-to-monitor-down; }
        # Mod+Shift+Ctrl+Up    { move-column-to-monitor-up; }
        # Mod+Shift+Ctrl+Right { move-column-to-monitor-right; }
        # Mod+Shift+Ctrl+J     { move-column-to-monitor-down; }
        # Mod+Shift+Ctrl+K     { move-column-to-monitor-up; }

        # // Alternatively, there are commands to move just a single window:
        # // Mod+Shift+Ctrl+Left  { move-window-to-monitor-left; }
        # // ...

        # // And you can also move a whole workspace to another monitor:
        # // ...

        # Workspaces
        "Mod+Page_Down".action.focus-workspace-down = [ ];
        "Mod+Page_Up".action.focus-workspace-up = [ ];
        "Mod+U".action.focus-workspace-down = [ ];
        "Mod+I".action.focus-workspace-up = [ ];
        "Mod+Shift+Page_Down".action.move-column-to-workspace-down = [ ];
        "Mod+Shift+Page_Up".action.move-column-to-workspace-up = [ ];
        "Mod+Shift+U".action.move-column-to-workspace-down = [ ];
        "Mod+Shift+I".action.move-column-to-workspace-up = [ ];

        # // Alternatively, there are commands to move just a single window:
        # // Mod+Ctrl+Page_Down { move-window-to-workspace-down; }
        # // ...

        "Mod+Ctrl+Page_Down".action.move-workspace-down = [ ];
        "Mod+Ctrl+Page_Up".action.move-workspace-up = [ ];
        "Mod+Ctrl+U".action.move-workspace-down = [ ];
        "Mod+Ctrl+I".action.move-workspace-up = [ ];

        # // You can bind mouse wheel scroll ticks using the following syntax.
        # // These binds will change direction based on the natural-scroll setting.
        # //
        # // To avoid scrolling through workspaces really fast, you can use
        # // the cooldown-ms property. The bind will be rate-limited to this value.
        # // You can set a cooldown on any bind, but it's most useful for the wheel.
        "Mod+WheelScrollDown" = {
          action.focus-workspace-down = [ ];
          cooldown-ms = 150;
        };
        "Mod+WheelScrollUp" = {
          action.focus-workspace-up = [ ];
          cooldown-ms = 150;
        };
        "Mod+Shift+WheelScrollDown" = {
          action.move-column-to-workspace-down = [ ];
          cooldown-ms = 150;
        };
        "Mod+Shift+WheelScrollUp" = {
          action.move-column-to-workspace-up = [ ];
          cooldown-ms = 150;
        };

        "Mod+WheelScrollRight".action.focus-column-right = [ ];
        "Mod+WheelScrollLeft".action.focus-column-left = [ ];
        "Mod+Shift+WheelScrollRight".action.move-column-right = [ ];
        "Mod+Shift+WheelScrollLeft".action.move-column-left = [ ];

        "Mod+Ctrl+Shift+WheelScrollDown".action.move-column-right = [ ];
        "Mod+Ctrl+Shift+WheelScrollUp".action.move-column-left = [ ];

        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = 7;
        "Mod+8".action.focus-workspace = 8;
        "Mod+9".action.focus-workspace = 9;
        "Mod+Shift+1".action.move-column-to-workspace = 1;
        "Mod+Shift+2".action.move-column-to-workspace = 2;
        "Mod+Shift+3".action.move-column-to-workspace = 3;
        "Mod+Shift+4".action.move-column-to-workspace = 4;
        "Mod+Shift+5".action.move-column-to-workspace = 5;
        "Mod+Shift+6".action.move-column-to-workspace = 6;
        "Mod+Shift+7".action.move-column-to-workspace = 7;
        "Mod+Shift+8".action.move-column-to-workspace = 8;
        "Mod+Shift+9".action.move-column-to-workspace = 9;

        # Consume/Expell
        "Mod+BracketLeft".action.consume-or-expel-window-left = [ ];
        "Mod+BracketRight".action.consume-or-expel-window-right = [ ];
        "Mod+Comma".action.consume-window-into-column = [ ];
        "Mod+Period".action.expel-window-from-column = [ ];

        # Sizing
        "Mod+R".action.switch-preset-column-width = [ ];
        "Mod+Shift+R".action.switch-preset-column-width-back = [ ];

        "Mod+Ctrl+R".action.switch-preset-window-height = [ ];
        "Mod+Ctrl+Alt+R".action.reset-window-height = [ ];

        "Mod+F" = {
          action.maximize-column = [ ];
          hotkey-overlay.title = "Maximize Column";
        };
        "Mod+Alt+F" = {
          action.maximize-window-to-edges = [ ];
          hotkey-overlay.title = "Make window Maximized";
        };
        "Mod+Shift+F" = {
          action.fullscreen-window = [ ];
          hotkey-overlay.title = "Make window Full screen";
        };
        "Mod+Shift+Alt+F" = {
          action.toggle-windowed-fullscreen = [ ];
          hotkey-overlay.title = "Trick window into thinking it's Full screen";
        };
        "Mod+Minus".action.set-column-width = "-10%";
        "Mod+Equal".action.set-column-width = "+10%";
        "Mod+Ctrl+Minus".action.set-window-height = "-10%";
        "Mod+Ctrl+Equal".action.set-window-height = "+10%";

        "Mod+Ctrl+F".action.expand-column-to-available-width = [ ];

        # Positioning
        "Mod+C".action.center-column = [ ];
        "Mod+Ctrl+C".action.center-visible-columns = [ ];

        # Window modes
        "Mod+V".action.toggle-window-floating = [ ];
        "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = [ ];
        "Mod+T".action.toggle-column-tabbed-display = [ ];

        "Print" = {
          action.screenshot = [ ];
          hotkey-overlay.title = "Screenshot of the selection";
        };
        "Shift+Print" = {
          action.screenshot-screen = [ ];
          hotkey-overlay.title = "Screenshot of the entire screen";
        };
        "Mod+Print" = {
          action.screenshot-window = [ ];
          hotkey-overlay.title = "Screenshot of the active window";
        };
        "Ctrl+Print" = {
          action.spawn-sh = [
            "wl-paste --type image/png | satty -f -"
          ];
          hotkey-overlay.title = "Edit clipboard image contents";
        };

        "Mod+Escape" = {
          allow-inhibiting = false;
          action.toggle-keyboard-shortcuts-inhibit = [ ];
        };

        "Ctrl+Alt+Delete".action.quit = [ ];
        "Mod+Shift+P" = {
          action.power-off-monitors = [ ];
          hotkey-overlay.title = "Blackout";
        };
        "Mod+P" = {
          action.spawn-sh = "wl-mirror $(niri msg --json focused-output | jq -r .name)";
          repeat = false;
          hotkey-overlay.title = "So called Screen Mirroring";
        };
      };
    };
  };

}
