let
  style = import ../../../../shared/constants/style.nix;
in
{
  programs.niri = {
    settings = {
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
        }
      ];
    };
  };
}
