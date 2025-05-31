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
                "applications:org.kde.kontact.desktop"
                "applications:systemsettings.desktop"
                "applications:org.kde.konsole.desktop"
                "applications:codium.desktop"
                "applications:appflowy.desktop"
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

# [ActionPlugins][0]
# RightButton;NoModifier=org.kde.contextmenu

# [ActionPlugins][1]
# RightButton;NoModifier=org.kde.contextmenu

# [Containments][1]
# ItemGeometries-2560x1440=
# ItemGeometriesHorizontal=
# activityId=775e9937-87ae-430c-927b-5e2e1d8cbcf1
# formfactor=0
# immutability=1
# lastScreen=0
# location=0
# plugin=org.kde.plasma.folder
# wallpaperplugin=org.kde.image

# [Containments][1][General]
# positions={"2560x1440":[]}

# [Containments][1][Wallpaper][org.kde.image][General]
# Image=/home/drakolis/nix-nyx/files/images/nix-wallpaper.png
# SlidePaths=/nix/store/bwrv1z1hk2qq7qj2zapnvk348l6d7rnd-breeze-6.3.4/share/wallpapers/,/run/current-system/sw/share/wallpapers/

# [Containments][57]
# activityId=
# formfactor=2
# immutability=1
# lastScreen=0
# location=4
# plugin=org.kde.panel
# wallpaperplugin=org.kde.image

# [Containments][57][Applets][116][Configuration]
# selectedConfig=0

# [Containments][57][Applets][58]
# immutability=1
# plugin=org.kde.plasma.kickoff

# [Containments][57][Applets][58][Configuration]
# PreloadWeight=100
# popupHeight=539
# popupWidth=699

# [Containments][57][Applets][58][Configuration][ConfigDialog]
# DialogHeight=540
# DialogWidth=720

# [Containments][57][Applets][58][Configuration][General]
# favoritesPortedToKAstats=true
# icon=nix-snowflake
# systemFavorites=suspend\\,hibernate\\,reboot\\,shutdown

# [Containments][57][Applets][59]
# immutability=1
# plugin=org.kde.plasma.pager

# [Containments][57][Applets][59][Configuration][ConfigDialog]
# DialogHeight=540
# DialogWidth=720

# [Containments][57][Applets][59][Configuration][General]
# displayedText=Number
# showWindowOutlines=false

# [Containments][57][Applets][60]
# immutability=1
# plugin=org.kde.plasma.icontasks

# [Containments][57][Applets][60][Configuration][ConfigDialog]
# DialogHeight=540
# DialogWidth=720

# [Containments][57][Applets][60][Configuration][General]
# fill=false
# launchers=preferred://filemanager,applications:org.kde.falkon.desktop,preferred://browser,applications:org.kde.kontact.desktop,applications:systemsettings.desktop,applications:org.kde.konsole.desktop,applications:codium.desktop,applications:appflowy.desktop,applications:obsidian.desktop

# [Containments][57][Applets][61]
# immutability=1
# plugin=org.kde.plasma.marginsseparator

# [Containments][57][Applets][61][Configuration][ConfigDialog]
# DialogHeight=540
# DialogWidth=720

# [Containments][57][Applets][62]
# immutability=1
# plugin=org.kde.plasma.systemtray

# [Containments][57][Applets][62][Configuration]
# PreloadWeight=100
# SystrayContainmentId=63

# [Containments][57][Applets][75]
# immutability=1
# plugin=org.kde.plasma.digitalclock

# [Containments][57][Applets][75][Configuration]
# PreloadWeight=100
# popupHeight=450
# popupWidth=810

# [Containments][57][Applets][75][Configuration][Appearance]
# enabledCalendarPlugins=pimevents,astronomicalevents,holidaysevents
# showSeconds=Always

# [Containments][57][Applets][75][Configuration][ConfigDialog]
# DialogHeight=540
# DialogWidth=720

# [Containments][57][Applets][76]
# immutability=1
# plugin=org.kde.plasma.showdesktop

# [Containments][57][Applets][81]
# immutability=1
# plugin=org.kde.plasma.panelspacer

# [Containments][57][Applets][82]
# immutability=1
# plugin=org.kde.plasma.panelspacer

# [Containments][57][Applets][86][Configuration]
# PreloadWeight=100
# passiveStates=
# popupHeight=450
# popupWidth=560
# preferIconsFromTheme=false
# selectedConfig=0
# showDownloads=false
# showTabTexts=false
# size=25,25

# [Containments][57][General]
# AppletOrder=59;82;58;60;81;61;62;75;76

# [Containments][63]
# activityId=
# formfactor=2
# immutability=1
# lastScreen=0
# location=4
# plugin=org.kde.plasma.private.systemtray
# popupHeight=432
# popupWidth=432
# wallpaperplugin=org.kde.image

# [Containments][63][Applets][115]
# immutability=1
# plugin=org.kde.plasma.mediacontroller

# [Containments][63][Applets][115][Configuration]
# PreloadWeight=0

# [Containments][63][Applets][64]
# immutability=1
# plugin=org.kde.plasma.cameraindicator

# [Containments][63][Applets][65]
# immutability=1
# plugin=org.kde.plasma.clipboard

# [Containments][63][Applets][65][Configuration]
# PreloadWeight=55

# [Containments][63][Applets][66]
# immutability=1
# plugin=org.kde.plasma.devicenotifier

# [Containments][63][Applets][66][Configuration]
# PreloadWeight=100

# [Containments][63][Applets][67]
# immutability=1
# plugin=org.kde.plasma.manage-inputmethod

# [Containments][63][Applets][67][Configuration]
# PreloadWeight=65

# [Containments][63][Applets][68]
# immutability=1
# plugin=org.kde.plasma.notifications

# [Containments][63][Applets][68][Configuration]
# PreloadWeight=100

# [Containments][63][Applets][69]
# immutability=1
# plugin=org.kde.kdeconnect

# [Containments][63][Applets][69][Configuration]
# PreloadWeight=90

# [Containments][63][Applets][70]
# immutability=1
# plugin=org.kde.kscreen

# [Containments][63][Applets][70][Configuration]
# PreloadWeight=55

# [Containments][63][Applets][71]
# immutability=1
# plugin=org.kde.plasma.keyboardindicator

# [Containments][63][Applets][71][Configuration][ConfigDialog]
# DialogHeight=540
# DialogWidth=720

# [Containments][63][Applets][72]
# immutability=1
# plugin=org.kde.plasma.keyboardlayout

# [Containments][63][Applets][72][Configuration][ConfigDialog]
# DialogHeight=540
# DialogWidth=720

# [Containments][63][Applets][73]
# immutability=1
# plugin=org.kde.plasma.printmanager

# [Containments][63][Applets][74]
# immutability=1
# plugin=org.kde.plasma.volume

# [Containments][63][Applets][74][Configuration]
# PreloadWeight=100

# [Containments][63][Applets][74][Configuration][General]
# migrated=true

# [Containments][63][Applets][77]
# immutability=1
# plugin=org.kde.plasma.brightness

# [Containments][63][Applets][77][Configuration]
# PreloadWeight=0

# [Containments][63][Applets][78]
# immutability=1
# plugin=org.kde.plasma.battery

# [Containments][63][Applets][78][Configuration]
# PreloadWeight=5

# [Containments][63][Applets][79]
# immutability=1
# plugin=org.kde.plasma.networkmanagement

# [Containments][63][Applets][79][Configuration]
# PreloadWeight=100

# [Containments][63][Applets][80]
# immutability=1
# plugin=org.kde.plasma.bluetooth

# [Containments][63][Applets][80][Configuration]
# PreloadWeight=0

# [Containments][63][Applets][83][Configuration]
# PreloadWeight=72
# passiveStates=
# preferIconsFromTheme=false
# selectedConfig=0
# showDownloads=false
# showTabTexts=false
# size=25,25

# [Containments][63][Applets][84]
# immutability=1
# plugin=org.kde.plasma.weather

# [Containments][63][Applets][84][Configuration]
# PreloadWeight=81

# [Containments][63][Applets][84][Configuration][ConfigDialog]
# DialogHeight=540
# DialogWidth=720

# [Containments][63][Applets][84][Configuration][Units]
# pressureUnit=5008
# speedUnit=9000
# temperatureUnit=6001
# visibilityUnit=2007

# [Containments][63][Applets][84][Configuration][WeatherStation]
# source=bbcukmet|weather|Berlin, Germany, DE|2950159

# [Containments][63][Applets][85]
# immutability=1
# plugin=org.kde.plasma.addons.katesessions

# [Containments][63][Applets][85][Configuration]
# PreloadWeight=85

# [Containments][63][Applets][86][Configuration]
# PreloadWeight=60
# passiveStates=
# preferIconsFromTheme=false
# selectedConfig=0
# showDownloads=false
# showTabTexts=false
# size=25,25

# [Containments][63][ConfigDialog]
# DialogHeight=540
# DialogWidth=720

# [Containments][63][General]
# extraItems=org.kde.plasma.cameraindicator,org.kde.plasma.clipboard,org.kde.plasma.devicenotifier,org.kde.plasma.manage-inputmethod,org.kde.plasma.mediacontroller,org.kde.plasma.notifications,org.kde.kdeconnect,org.kde.kscreen,org.kde.plasma.battery,org.kde.plasma.bluetooth,org.kde.plasma.brightness,org.kde.plasma.keyboardindicator,org.kde.plasma.keyboardlayout,org.kde.plasma.networkmanagement,org.kde.plasma.printmanager,org.kde.plasma.volume,org.kde.plasma.weather,org.kde.plasma.addons.katesessions
# hiddenItems=Proton,Xwayland Video Bridge_pipewireToXProxy,crow-translate,org.kde.plasma.addons.katesessions,Yakuake
# knownItems=org.kde.plasma.cameraindicator,org.kde.plasma.clipboard,org.kde.plasma.devicenotifier,org.kde.plasma.manage-inputmethod,org.kde.plasma.mediacontroller,org.kde.plasma.notifications,org.kde.kdeconnect,org.kde.kscreen,org.kde.plasma.battery,org.kde.plasma.bluetooth,org.kde.plasma.brightness,org.kde.plasma.keyboardindicator,org.kde.plasma.keyboardlayout,org.kde.plasma.networkmanagement,org.kde.plasma.printmanager,org.kde.plasma.volume
# shownItems=org.kde.plasma.clipboard,org.kde.plasma.weather

# [Containments57Appletsts][103][Configuration][General]
# savedAt=2025,3,15,9,26,52.127
# showProgressBar=true

# [Containments95Appletsts][105][Configuration][Appearance]
# fillThickness=true
# fontSize=15

# [ScreenMapping]
# itemsOnDisabledScreens=
# screenMapping=
