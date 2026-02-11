{
  programs.niri = {
    settings = {
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

      window-rules = [
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
            {
              app-id = "org.gnome.Characters";
            }
          ];
          open-floating = true;
          default-window-height.fixed = 600;
          default-column-width.proportion = 0.45;
        }
        {
          # Rules for character and emoji pickers
          matches = [
            {
              app-id = "it.mijorus.smile";
            }
          ];
          open-floating = true;
          default-window-height.fixed = 300;
          default-column-width.proportion = 0.25;
        }
      ];
    };
  };
}
