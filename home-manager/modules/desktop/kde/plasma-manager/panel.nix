{
  programs.plasma = {
    panels = [
      {
        alignment = "center";
        floating = true;
        height = 44;
        hiding = null;
        lengthMode = "fill";
        location = "bottom";
        opacity = "opaque";
        screen = "all";
        widgets = [
          {
            pager = {
              general = {
                showWindowOutlines = false;
                showApplicationIconsOnWindowOutlines = false;
                showOnlyCurrentScreen = false;
                navigationWrapsAround = false;
                displayedText = "desktopNumber";
                selectingCurrentVirtualDesktop = "showDesktop";
              };
            };
          }
          "org.kde.plasma.panelspacer"
          {
            kickoff = {
              icon = "nix-snowflake";
            };
          }
          {
            iconTasks = {
              launchers = [
                "preferred://filemanager"
                "applications:org.kde.falkon.desktop"
                "preferred://browser"
                "applications:org.kde.kmail2.desktop"
                "applications:systemsettings.desktop"
                "applications:org.kde.konsole.desktop"
                "applications:dev.zed.Zed.desktop"
                "applications:obsidian.desktop"
              ];
              appearance = {
                fill = false;
              };
            };
          }
          "org.kde.plasma.panelspacer"
          "org.kde.plasma.marginsseparator"
          {
            systemTray = {
              items = {
                shown = [
                  "org.kde.plasma.clipboard"
                  "org.kde.plasma.weather"
                ];
                hidden = [
                  "Proton"
                  "Xwayland Video Bridge_pipewireToXProxy"
                  "crow-translate"
                  "org.kde.plasma.addons.katesessions"
                  "Yakuake"
                ];
                extra = [
                  "org.kde.plasma.cameraindicator"
                  "org.kde.plasma.clipboard"
                  "org.kde.plasma.devicenotifier"
                  "org.kde.plasma.manage-inputmethod"
                  "org.kde.plasma.mediacontroller"
                  "org.kde.plasma.notifications"
                  "org.kde.kdeconnect"
                  "org.kde.kscreen"
                  "org.kde.plasma.battery"
                  "org.kde.plasma.bluetooth"
                  "org.kde.plasma.brightness"
                  "org.kde.plasma.keyboardindicator"
                  "org.kde.plasma.keyboardlayout"
                  "org.kde.plasma.networkmanagement"
                  "org.kde.plasma.printmanager"
                  "org.kde.plasma.volume"
                  "org.kde.plasma.weather"
                  "org.kde.plasma.addons.katesessions"
                  "martchus.syncthingplasmoid"
                ];
                configs = {
                  "org.kde.plasma.weather" = {
                    config = {
                      WeatherStation = "bbcukmet|weather|Berlin, Germany, DE|2950159";
                    };
                  };
                };
              };
            };
          }
          {
            digitalClock = {
              time = {
                showSeconds = "always";
              };
              calendar = {
                plugins = [
                  "pimevents"
                  "astronomicalevents"
                  "holidaysevents"
                ];
              };
            };
          }
          "org.kde.plasma.showdesktop"
        ];

        extraSettings = "";
      }
    ];
  };
}
