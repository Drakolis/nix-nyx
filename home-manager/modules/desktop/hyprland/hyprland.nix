{ pkgs, ... }:
let
  style = import ../../../../constants/style.nix;
  commands = import ../../../../constants/commands.nix;
  paths = import ../../../../constants/paths.nix;
in
{
  home.packages = with pkgs; [
    (writeShellScriptBin "toggle-hyprland-animations" ''
      on=$(hyprctl -j getoption animations:enabled | jq --raw-output '.int')

      if [[ $on -eq 1 ]]; then
          hyprctl keyword animations:enabled 0
          notify-send -a "hyprland" -i "user-cat-mocha-green-desktop" "hyprland" "Animations off"
      else
          hyprctl keyword animations:enabled 1
          notify-send -a "hyprland" -i "user-cat-mocha-mauve-desktop" "hyprland" "Animations on"
      fi
    '')
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    # plugins = [ pkgs.hyprlandPlugins.hyprexpo ];
    settings = {
      env = [
        "EDITOR, ${commands.tui.editor}"
        "TERMINAL, ${commands.terminal}"
        "QT_QPA_PLATFORMTHEME, qt5ct"
        "QT_STYLE_OVERRIDE, kvantum"
        "GDK_BACKEND, wayland"
        "GDK_SCALE, 1"
        "GSK_RENDERER, cairo"
      ];
      monitor = [
        "DP-1,2560x1440@144,1920x0,1"
        "eDP-1,1920x1080@60,0x0,1.2"
      ];
      layerrule = [
        "blur, rofi"
        "blur, wofi"
        "blur, walker"
      ];
      xwayland = {
        force_zero_scaling = true;
      };
      "$mainMod" = "SUPER";
      exec-once = [
        "brightnessctl -sd tpacpi::kbd_backlight set 2"
        # "wl-paste --type text --watch cliphist store"
        # "wl-paste --type image --watch cliphist store"
      ]
      ++ commands.autostart;
      general = {
        border_size = style.border.outer.width;
        gaps_in = style.gaps.inner;
        gaps_out = [
          style.gaps.inner
          style.gaps.outer
          style.gaps.outer
          style.gaps.outer
        ];
        "col.active_border" = "rgb(${style.colors.primary})";
        "col.inactive_border" = "rgb(${style.colors.panel})";
        "col.nogroup_border_active" = "rgb(${style.colors.locked})";
        "col.nogroup_border" = "rgb(${style.colors.panel})";
        layout = "dwindle";
        resize_on_border = true;
        extend_border_grab_area = style.gaps.inner;
        allow_tearing = false;
        snap = {
          enabled = true;
        };
      };
      decoration = {
        rounding = style.border.outer.radius;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        fullscreen_opacity = 1.0;
        dim_inactive = true;
        dim_strength = 0.15;
        dim_special = 0.3;
        blur = {
          enabled = true;
          size = 5;
          passes = 1;
          vibrancy = 0.1696;
        };

        shadow = {
          enabled = true;
          range = 5;
          render_power = 2;
          color = "rgb(${style.colors.shadow})";
        };
      };
      animations = {
        enabled = true;
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];
        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };
      input = {
        kb_layout = "us, ru";
        kb_options = "grp:ctrl_space_toggle, compose:sclk, compose:ralt, apple:alupckeys";
        numlock_by_default = true;
        sensitivity = 0;
        follow_mouse = 1;
        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
        };
      };
      # gestures = {
      #   workspace_swipe = true;
      # };
      misc = {
        font_family = style.fontGuiNerd;
        disable_hyprland_logo = true;
        background_color = "rgb(${style.colors.background})";
        focus_on_activate = true; # Ensure new popups get focus
        animate_manual_resizes = false; # Prevent weird behavior on popups
      };
      group = {
        "col.border_active" = "rgb(${style.colors.primary})";
        "col.border_inactive" = "rgb(${style.colors.panel})";
        "col.border_locked_active" = "rgb(${style.colors.locked})";
        "col.border_locked_inactive" = "rgb(${style.colors.panel})";
        groupbar = {
          font_family = style.fontGuiNerd;
          font_size = style.fontSizeLarger;
          height = 20;
          text_offset = -2;
          gradient_rounding = 5;
          indicator_height = 0;
          font_weight_active = "bold";
          font_weight_inactive = "bold";
          gradients = true;
          text_color = "rgb(${style.colors.textInverted})";
          "col.active" = "rgb(${style.colors.primary})";
          "col.inactive" = "rgba(${style.colors.primary}a0)";
          "col.locked_active" = "rgb(${style.colors.locked})";
          "col.locked_inactive" = "rgba(${style.colors.locked}a0)";
        };
      };
      cursor = {
        sync_gsettings_theme = false;
        no_hardware_cursors = true;
      };
      plugin = {
        hyprexpo = {
          columns = 3;
          gap_size = 5;
          bg_col = "rgb(${style.colors.shadow})";
          workspace_method = "first 1"; # [center/first] [workspace] e.g. first 1 or center m+1

          enable_gesture = true; # laptop touchpad
          gesture_fingers = 3; # 3 or 4
          gesture_distance = 300; # how far is the "max"
          gesture_positive = true; # positive = swipe down. Negative = swipe up.
        };
      };
      bind = [
        "$mainMod, RETURN, exec, ${commands.terminal}"
        "$mainMod SHIFT, RETURN, exec, ghostty"

        # Kill actions
        "$mainMod, Q, killactive, "
        "$mainMod SHIFT, Q, exec, ${commands.dialogues.shutdown}"
        "CTRL ALT, DELETE, exit, "

        # Window Controls
        "$mainMod, O, togglefloating, "
        "$mainMod, I, pin, "
        "$mainMod, U, centerwindow, "
        "$mainMod, P, pseudo, "
        "$mainMod, J, togglesplit, "
        "$mainMod, F, fullscreen, "

        "$mainMod, G, togglegroup, "
        "$mainMod ALT, G, lockactivegroup, toggle"
        "$mainMod SHIFT, G, moveoutofgroup, "
        "$mainMod, TAB, changegroupactive, f"
        "$mainMod SHIFT, TAB, changegroupactive, b"

        "$mainMod SHIFT, F5, exec, systemctl --user restart waybar"
        "$mainMod, L, exec, loginctl lock-session"
        "$mainMod, K, exec, ${commands.notifyHyprpicker} & hyprpicker -a"
        "$mainMod, N, exec, swaync-client -t"
        "$mainMod SHIFT, N, exec, swaync-client -d"
        ", Print, exec, hyprshot -z -m region -o ${paths.screenshots} ${commands.previewScreenshot}"
        "CTRL, Print, exec, hyprshot -z -m output -o ${paths.screenshots} ${commands.previewScreenshot}"
        "$mainMod, Print, exec, hyprshot -m window -o ${paths.screenshots} ${commands.previewScreenshot}"

        # "$mainMod, grave, hyprexpo:expo, toggle"

        # Window Navigation
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        "$mainMod SHIFT, left, movewindow, l"
        "$mainMod SHIFT, right, movewindow, r"
        "$mainMod SHIFT, up, movewindow, u"
        "$mainMod SHIFT, down, movewindow, d"

        "$mainMod CTRL, left, swapwindow, l"
        "$mainMod CTRL, right, swapwindow, r"
        "$mainMod CTRL, up, swapwindow, u"
        "$mainMod CTRL, down, swapwindow, d"

        "$mainMod ALT, left, movewindoworgroup, l"
        "$mainMod ALT, right, movewindoworgroup, r"
        "$mainMod ALT, up, movewindoworgroup, u"
        "$mainMod ALT, down, movewindoworgroup, d"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        # Example special workspace (scratchpad)
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        # Launchers
        "$mainMod, Z, exec, ${commands.terminal} ${commands.tui.fileManager}"
        "$mainMod SHIFT, Z, exec, ${commands.gui.fileManager}"
        "$mainMod, B, exec, ${commands.gui.browser}"
        "$mainMod, T, exec, qalculate-gtk"
        "$mainMod, E, exec, ${commands.terminal} ${commands.tui.editor}"
        "$mainMod SHIFT, E, exec, ${commands.gui.editor}"
        "$mainMod, M, exec, ${commands.terminal} (wl-paste | xargs ${commands.previewText})"
        "$mainMod, Y, exec, ${commands.gui.passwords}"

        # Runner
        "$mainMod, SPACE, exec, ${commands.dialogues.runner}"
        "$mainMod, V, exec, ${commands.dialogues.runnerClipboard}"
        "$mainMod SHIFT, SPACE, exec, ${commands.dialogues.runnerShift}"

        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"

        "$mainMod, F4, exec, toggle-hyprland-animations"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (
          builtins.genList (
            i:
            let
              ws = i + 1;
            in
            [
              "$mainMod, code:1${toString i}, workspace, ${toString ws}"
              "$mainMod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          ) 9
        )
      );
      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
      bindel = [
        # Locked and repeated on press
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"

        ", XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ", XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ];
      bindl = [
        # Locked
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
      ];
      bindlo = [
        # Locked and long press
        ", XF86AudioPrev, exec, playerctl position -5"
        ", XF86AudioNext, exec, playerctl position +5"
      ];
      bindo = [
        # Long press
      ];
      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"

        # Floating windows
        "float,class:^(qalculate).*$"
        "size 600 600,class:^(qalculate)$"

        # Password Dialogues
        "float,class:^(pinentry-gtk)$"
        "center,class:^(pinentry-gtk)$"
        "size 750 150,class:^(pinentry-gtk)$"

        # Save/Open Dialogues
        "float,title:^((Open|Save).*)$"
        "center,title:^((Open|Save).*)$"
        "size 800 600,title:^((Open|Save).*)$"

        # File operations in Thunar
        "float,class:^(thunar)$,title:^(File Operation Progress)$"

        # Screenshot dialogues
        "float,class:^(Screenshot)$"
        "center,title:^(Screenshot)$"
        "size 800 600,title:^(Screenshot)$"

        # "workspace special:writing silent,class:^(writing)$"

        # Password manager rules
        "float,class:^(org.keepassxc.KeePassXC)$"
        "center,class:^(org.keepassxc.KeePassXC)$"
        "float,class:^(Proton Pass)$"
        "center,class:^(Proton Pass)$"

        # Fix for shadow blurs being broken
        "noblur,class:^()$,title:^()$"
      ];
    };
  };
}
