{
  programs.niri = {
    settings = {
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
          accel-speed = 0.1;
          accel-profile = "flat";
          scroll-method = "on-button-down";
          scroll-button = 274;
          scroll-button-lock = true;
          natural-scroll = false;
        };
        trackpoint = {
          enable = true;
          accel-speed = 0.2;
          accel-profile = "flat";
          natural-scroll = false;
          scroll-method = null;
        };
        warp-mouse-to-focus.enable = true;
      };

      switch-events = {
        lid-close.action.spawn = [
          "niri"
          "msg"
          "action power-off-monitors"
        ];
        lid-open.action.spawn = [
          "niri"
          "msg"
          "action power-on-monitors"
        ];
        #   tablet-mode-on.action.spawn = ["gsettings" "set" "org.gnome.desktop.a11y.applications" "screen-keyboard-enabled" "true"];
        #   tablet-mode-off.action.spawn = ["gsettings" "set" "org.gnome.desktop.a11y.applications" "screen-keyboard-enabled" "false"];
      };

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
    };
  };
}
