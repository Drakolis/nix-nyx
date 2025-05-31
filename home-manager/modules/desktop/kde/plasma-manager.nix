{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.drakolis.kde;
in
with lib;
{
  options = {
    drakolis.kde = {
      isLaptop = mkOption {
        default = true;
        type = types.bool;
        description = ''
          Run a lighter config and lower power consumption.
        '';
      };
      isServer = mkOption {
        default = true;
        type = types.bool;
        description = ''
          Will turn off the sleep mode entirely.
        '';
      };
    };
  };

  config = {
    programs.okular = {
      enable = true;
      package = null;
    };

    programs.plasma = {
      enable = true;
      # https://github.com/nix-community/plasma-manager/blob/trunk/examples/home.nix
      # https://nix-community.github.io/plasma-manager/options.xhtml

      krunner = {
        activateWhenTypingOnDesktop = true;
        historyBehavior = "enableAutoComplete";
        position = "center";
        shortcuts.launch = "Meta+Space";
        shortcuts.runCommandOnClipboard = "Meta+Shift+Space";
      };

      configFile.krunnerrc = {
        Plugins = {
          krunner_appstreamEnabled = false;
          krunner_konsoleprofilesEnabled = false;
          plasma-runner-neochatEnabled = true;
        };

        "Plugins/Favorites"."plugins" = "krunner_services,krunner_bookmarksrunner,krunner_systemsettings";

        "Runners/krunner_charrunner" = {
          "aliases" = "";
          "codes" = "";
          "triggerWord" = "#";
        };

        "Runners/krunner_kill" = {
          "sorting" = 1;
          "triggerWord" = "kill";
          "useTriggerWord" = true;
        };
      };

      spectacle.shortcuts = {
        captureActiveWindow = "Meta+Print";
        captureCurrentMonitor = "";
        captureEntireDesktop = "Shift+Print";
        captureRectangularRegion = "Print";
        captureWindowUnderCursor = "";
        launch = "Meta+Shift+Print";
        launchWithoutCapturing = "";
        recordRegion = "Ctrl+Print";
        recordScreen = "Ctrl+Shift+Print";
        recordWindow = "Meta+Ctrl+Print";
      };

      configFile.spectaclerc = {
        Annotations = {
          annotationToolType = 10;
          freehandStrokeColor = "243,139,168";
          highlighterStrokeColor = "249,226,175";
          lineStrokeColor = "243,139,168";
          arrowStrokeColor = "243,139,168";
          numberFillColor = "245,189,230";
          numberFontColor = "24,25,38";
          textFontColor = "205,214,244";
        };
        ImageSave.translatedScreenshotsFolder = "Screenshots";
        VideoSave.translatedScreencastsFolder = "Screencasts";
      };

      shortcuts = {
        "services/net.local.kget.desktop"."_launch" = "Meta+Alt+V";

        "services/org.kde.CrowTranslate.desktop" = {
          "SpeakTranslatedSelection" = "Meta+Shift+C";
          "TranslateSelectedText" = "Meta+C";
        };

        "services/org.kde.dolphin.desktop"."_launch" = "Meta+Z";

        "services/org.kde.konsole.desktop"."_launch" = "Meta+Return";

        "yakuake"."toggle-window-state" = "Meta+`";
      };

      desktop.widgets = [ ];

      fonts.fixedWidth = {
        family = "Hack Nerd Font";
        pointSize = 11;
      };
      # fonts.general = {
      #   family = "Hack Nerd Font";
      #   pointSize = 11;
      # };
      # fonts.menu = {
      #   family = "Hack Nerd Font";
      #   pointSize = 11;
      # };
      # fonts.small = {
      #   family = "Hack Nerd Font";
      #   pointSize = 9;
      # };
      # fonts.toolbar = {
      #   family = "Hack Nerd Font";
      #   pointSize = 11;
      # };

      input.keyboard = {
        layouts = [
          {
            layout = "nz";
          }
          {
            layout = "ru";
          }
        ];

        numlockOnStartup = "on";

        options = [
          "grp:ctrl_space_toggle"
          "compose:sclk"
          "compose:ralt"
          "apple:alupckeys"
        ];

        switchingPolicy = "window";
      };

      input.touchpads = [
        {
          name = "SynPS/2 Synaptics TouchPad";
          productId = "0007";
          vendorId = "0002";
          disableWhileTyping = true;
          enable = true;
          naturalScroll = true;
        }
      ];

      session = {
        sessionRestore = {
          restoreOpenApplicationsOnLogin = "onLastLogout"; # "whenSessionWasManuallySaved"
          excludeApplications = [ ];
        };
        general.askForConfirmationOnLogout = true;
      };

      windows = {
        allowWindowsToRememberPositions = true;
      };

      workspace = {
        enableMiddleClickPaste = false;
      };

      configFile.kwalletrc = {
        Wallet = {
          "First Use" = false;
          "Enabled" = true;

          "Close When Idle" = false;
          "Close on Screensaver" = false;
          "Leave Open" = true;
          "Idle Timeout" = 10;

          "Default Wallet" = "kdewallet";
          "Use One Wallet" = true;

          "Launch Manager" = false;
          "Leave Manager Open" = false;

          "Prompt on Open" = true;
        };
        "org.freedesktop.secrets"."apiEnabled" = true;
      };

      # shortcuts = {
      #   "KDE Keyboard Layout Switcher"."Switch to Last-Used Keyboard Layout" =
      #     "none,Meta+Alt+L,Switch to Last-Used Keyboard Layout";
      #   "KDE Keyboard Layout Switcher"."Switch to Next Keyboard Layout" =
      #     "Hiragana Katakana,Meta+Alt+K,Switch to Next Keyboard Layout";
      #   "kaccess"."Toggle Screen Reader On and Off" =
      #     "none,Meta+Alt+S,Toggle Screen Reader On and Off";
      #   "kcm_touchpad"."Disable Touchpad" = "Touchpad Off";
      #   "kcm_touchpad"."Enable Touchpad" = "Touchpad On";
      #   "kcm_touchpad"."Toggle Touchpad" = [
      #     "Touchpad Toggle"
      #     "Meta+Ctrl+Zenkaku Hankaku,Touchpad Toggle"
      #     "Touchpad Toggle"
      #     "Meta+Ctrl+Touchpad Toggle"
      #     "Meta+Ctrl+Zenkaku Hankaku"
      #   ];
      #   "kmix"."decrease_microphone_volume" = [
      #     "Microphone Volume Down"
      #     "Meta+Volume Down,Microphone Volume Down,Decrease Microphone Volume"
      #   ];
      #   "kmix"."decrease_volume" = "Volume Down";
      #   "kmix"."decrease_volume_small" = "Shift+Volume Down";
      #   "kmix"."increase_microphone_volume" = [
      #     "Meta+Volume Up"
      #     "Microphone Volume Up,Microphone Volume Up,Increase Microphone Volume"
      #   ];
      #   "kmix"."increase_volume" = "Volume Up";
      #   "kmix"."increase_volume_small" = "Shift+Volume Up";
      #   "kmix"."mic_mute" = [
      #     "Microphone Mute"
      #     "Meta+Volume Mute,Microphone Mute"
      #     "Meta+Volume Mute,Mute Microphone"
      #   ];
      #   "kmix"."mute" = "Volume Mute";
      #   "konversation"."next_active_tab" = [ ];
      #   "konversation"."toggle_mainwindow_visibility" = [ ];
      #   "ksmserver"."Halt Without Confirmation" =
      #     "none,,Shut Down Without Confirmation";
      #   "ksmserver"."Lock Session" =
      #     [ "Meta+L" "Screensaver,Meta+L" "Screensaver,Lock Session" ];
      #   "ksmserver"."Log Out" = "Ctrl+Alt+Del";
      #   "ksmserver"."Log Out Without Confirmation" =
      #     "none,,Log Out Without Confirmation";
      #   "ksmserver"."LogOut" = "none,,Log Out";
      #   "ksmserver"."Reboot" = "none,,Reboot";
      #   "ksmserver"."Reboot Without Confirmation" =
      #     "none,,Reboot Without Confirmation";
      #   "ksmserver"."Shut Down" = "none,,Shut Down";
      #   "ktorrent"."queue_suspend" = "Alt+Shift+P";
      #   "ktorrent"."show_kt" = "Alt+Shift+T";
      #   "kwin"."Activate Window Demanding Attention" = "Meta+Ctrl+A";
      #   "kwin"."Cycle Overview" = [ ];
      #   "kwin"."Cycle Overview Opposite" = [ ];
      #   "kwin"."Decrease Opacity" =
      #     "none,,Decrease Opacity of Active Window by 5%";
      #   "kwin"."Edit Tiles" = "Meta+T";
      #   "kwin"."Expose" = "Ctrl+F9";
      #   "kwin"."ExposeAll" = [
      #     "Ctrl+F10"
      #     "Launch (C),Ctrl+F10"
      #     "Launch (C),Toggle Present Windows (All desktops)"
      #   ];
      #   "kwin"."ExposeClass" = "Ctrl+F7";
      #   "kwin"."ExposeClassCurrentDesktop" = [ ];
      #   "kwin"."Grid View" = "none,Meta+G,Toggle Grid View";
      #   "kwin"."Increase Opacity" =
      #     "none,,Increase Opacity of Active Window by 5%";
      #   "kwin"."Kill Window" = "none,Meta+Ctrl+Esc,Kill Window";
      #   "kwin"."Move Tablet to Next Output" = [ ];
      #   "kwin"."MoveMouseToCenter" = "Meta+F6";
      #   "kwin"."MoveMouseToFocus" = "Meta+F5";
      #   "kwin"."MoveZoomDown" = [ ];
      #   "kwin"."MoveZoomLeft" = [ ];
      #   "kwin"."MoveZoomRight" = [ ];
      #   "kwin"."MoveZoomUp" = [ ];
      #   "kwin"."Overview" = "Meta+F3,Meta+W,Toggle Overview";
      #   "kwin"."Setup Window Shortcut" = "none,,Setup Window Shortcut";
      #   "kwin"."Show Desktop" = "Meta+D";
      #   "kwin"."Switch One Desktop Down" =
      #     "none,Meta+Ctrl+Down,Switch One Desktop Down";
      #   "kwin"."Switch One Desktop Up" =
      #     "none,Meta+Ctrl+Up,Switch One Desktop Up";
      #   "kwin"."Switch One Desktop to the Left" =
      #     "none,Meta+Ctrl+Left,Switch One Desktop to the Left";
      #   "kwin"."Switch One Desktop to the Right" =
      #     "none,Meta+Ctrl+Right,Switch One Desktop to the Right";
      #   "kwin"."Switch Window Down" = "Meta+Alt+Down";
      #   "kwin"."Switch Window Left" = "Meta+Alt+Left";
      #   "kwin"."Switch Window Right" = "Meta+Alt+Right";
      #   "kwin"."Switch Window Up" = "Meta+Alt+Up";
      #   "kwin"."Switch to Desktop 1" = "Meta+1,Ctrl+F1,Switch to Desktop 1";
      #   "kwin"."Switch to Desktop 10" = "none,,Switch to Desktop 10";
      #   "kwin"."Switch to Desktop 11" = "none,,Switch to Desktop 11";
      #   "kwin"."Switch to Desktop 12" = "none,,Switch to Desktop 12";
      #   "kwin"."Switch to Desktop 13" = "none,,Switch to Desktop 13";
      #   "kwin"."Switch to Desktop 14" = "none,,Switch to Desktop 14";
      #   "kwin"."Switch to Desktop 15" = "none,,Switch to Desktop 15";
      #   "kwin"."Switch to Desktop 16" = "none,,Switch to Desktop 16";
      #   "kwin"."Switch to Desktop 17" = "none,,Switch to Desktop 17";
      #   "kwin"."Switch to Desktop 18" = "none,,Switch to Desktop 18";
      #   "kwin"."Switch to Desktop 19" = "none,,Switch to Desktop 19";
      #   "kwin"."Switch to Desktop 2" = "Meta+2,Ctrl+F2,Switch to Desktop 2";
      #   "kwin"."Switch to Desktop 20" = "none,,Switch to Desktop 20";
      #   "kwin"."Switch to Desktop 3" = "Meta+3,Ctrl+F3,Switch to Desktop 3";
      #   "kwin"."Switch to Desktop 4" = "Meta+4,Ctrl+F4,Switch to Desktop 4";
      #   "kwin"."Switch to Desktop 5" = "Meta+5,,Switch to Desktop 5";
      #   "kwin"."Switch to Desktop 6" = "Meta+6,,Switch to Desktop 6";
      #   "kwin"."Switch to Desktop 7" = "Meta+7,,Switch to Desktop 7";
      #   "kwin"."Switch to Desktop 8" = "Meta+8,,Switch to Desktop 8";
      #   "kwin"."Switch to Desktop 9" = "Meta+9,,Switch to Desktop 9";
      #   "kwin"."Switch to Next Desktop" = "Meta+PgUp,,Switch to Next Desktop";
      #   "kwin"."Switch to Next Screen" = "none,,Switch to Next Screen";
      #   "kwin"."Switch to Previous Desktop" =
      #     "Meta+PgDown,,Switch to Previous Desktop";
      #   "kwin"."Switch to Previous Screen" = "none,,Switch to Previous Screen";
      #   "kwin"."Switch to Screen 0" = "none,,Switch to Screen 0";
      #   "kwin"."Switch to Screen 1" = "none,,Switch to Screen 1";
      #   "kwin"."Switch to Screen 2" = "none,,Switch to Screen 2";
      #   "kwin"."Switch to Screen 3" = "none,,Switch to Screen 3";
      #   "kwin"."Switch to Screen 4" = "none,,Switch to Screen 4";
      #   "kwin"."Switch to Screen 5" = "none,,Switch to Screen 5";
      #   "kwin"."Switch to Screen 6" = "none,,Switch to Screen 6";
      #   "kwin"."Switch to Screen 7" = "none,,Switch to Screen 7";
      #   "kwin"."Switch to Screen Above" = "none,,Switch to Screen Above";
      #   "kwin"."Switch to Screen Below" = "none,,Switch to Screen Below";
      #   "kwin"."Switch to Screen to the Left" =
      #     "none,,Switch to Screen to the Left";
      #   "kwin"."Switch to Screen to the Right" =
      #     "none,,Switch to Screen to the Right";
      #   "kwin"."Toggle Night Color" = [ ];
      #   "kwin"."Toggle Window Raise/Lower" = "none,,Toggle Window Raise/Lower";
      #   "kwin"."Walk Through Windows" = "Meta+Tab,Alt+Tab,Walk Through Windows";
      #   "kwin"."Walk Through Windows (Reverse)" =
      #     "Meta+Shift+Tab,Alt+Shift+Tab,Walk Through Windows (Reverse)";
      #   "kwin"."Walk Through Windows Alternative" =
      #     "none,,Walk Through Windows Alternative";
      #   "kwin"."Walk Through Windows Alternative (Reverse)" =
      #     "none,,Walk Through Windows Alternative (Reverse)";
      #   "kwin"."Walk Through Windows of Current Application" = "Alt+`";
      #   "kwin"."Walk Through Windows of Current Application (Reverse)" = "Alt+~";
      #   "kwin"."Walk Through Windows of Current Application Alternative" =
      #     "none,,Walk Through Windows of Current Application Alternative";
      #   "kwin"."Walk Through Windows of Current Application Alternative (Reverse)" =
      #     "none,,Walk Through Windows of Current Application Alternative (Reverse)";
      #   "kwin"."Window Above Other Windows" = "none,,Keep Window Above Others";
      #   "kwin"."Window Below Other Windows" = "none,,Keep Window Below Others";
      #   "kwin"."Window Close" = "Meta+Q,Alt+F4,Close Window";
      #   "kwin"."Window Custom Quick Tile Bottom" =
      #     "none,,Custom Quick Tile Window to the Bottom";
      #   "kwin"."Window Custom Quick Tile Left" =
      #     "none,,Custom Quick Tile Window to the Left";
      #   "kwin"."Window Custom Quick Tile Right" =
      #     "none,,Custom Quick Tile Window to the Right";
      #   "kwin"."Window Custom Quick Tile Top" =
      #     "none,,Custom Quick Tile Window to the Top";
      #   "kwin"."Window Fullscreen" = "none,,Make Window Fullscreen";
      #   "kwin"."Window Grow Horizontal" = "none,,Expand Window Horizontally";
      #   "kwin"."Window Grow Vertical" = "none,,Expand Window Vertically";
      #   "kwin"."Window Lower" = "none,,Lower Window";
      #   "kwin"."Window Maximize" = "Meta+F,Meta+PgUp,Maximize Window";
      #   "kwin"."Window Maximize Horizontal" =
      #     "none,,Maximize Window Horizontally";
      #   "kwin"."Window Maximize Vertical" = "none,,Maximize Window Vertically";
      #   "kwin"."Window Minimize" = "Meta+W,Meta+PgDown,Minimize Window";
      #   "kwin"."Window Move" = "none,,Move Window";
      #   "kwin"."Window Move Center" = "none,,Move Window to the Center";
      #   "kwin"."Window No Border" = "none,,Toggle Window Titlebar and Frame";
      #   "kwin"."Window On All Desktops" = "none,,Keep Window on All Desktops";
      #   "kwin"."Window One Desktop Down" =
      #     "none,Meta+Ctrl+Shift+Down,Window One Desktop Down";
      #   "kwin"."Window One Desktop Up" =
      #     "none,Meta+Ctrl+Shift+Up,Window One Desktop Up";
      #   "kwin"."Window One Desktop to the Left" =
      #     "none,Meta+Ctrl+Shift+Left,Window One Desktop to the Left";
      #   "kwin"."Window One Desktop to the Right" =
      #     "none,Meta+Ctrl+Shift+Right,Window One Desktop to the Right";
      #   "kwin"."Window One Screen Down" = "none,,Move Window One Screen Down";
      #   "kwin"."Window One Screen Up" = "none,,Move Window One Screen Up";
      #   "kwin"."Window One Screen to the Left" =
      #     "none,,Move Window One Screen to the Left";
      #   "kwin"."Window One Screen to the Right" =
      #     "none,,Move Window One Screen to the Right";
      #   "kwin"."Window Operations Menu" = "Alt+F3";
      #   "kwin"."Window Pack Down" = "none,,Move Window Down";
      #   "kwin"."Window Pack Left" = "none,,Move Window Left";
      #   "kwin"."Window Pack Right" = "none,,Move Window Right";
      #   "kwin"."Window Pack Up" = "none,,Move Window Up";
      #   "kwin"."Window Quick Tile Bottom" = "Meta+Down";
      #   "kwin"."Window Quick Tile Bottom Left" =
      #     "none,,Quick Tile Window to the Bottom Left";
      #   "kwin"."Window Quick Tile Bottom Right" =
      #     "none,,Quick Tile Window to the Bottom Right";
      #   "kwin"."Window Quick Tile Left" = "Meta+Left";
      #   "kwin"."Window Quick Tile Right" = "Meta+Right";
      #   "kwin"."Window Quick Tile Top" = "Meta+Up";
      #   "kwin"."Window Quick Tile Top Left" =
      #     "none,,Quick Tile Window to the Top Left";
      #   "kwin"."Window Quick Tile Top Right" =
      #     "none,,Quick Tile Window to the Top Right";
      #   "kwin"."Window Raise" = "none,,Raise Window";
      #   "kwin"."Window Resize" = "none,,Resize Window";
      #   "kwin"."Window Shade" = "none,,Shade Window";
      #   "kwin"."Window Shrink Horizontal" = "none,,Shrink Window Horizontally";
      #   "kwin"."Window Shrink Vertical" = "none,,Shrink Window Vertically";
      #   "kwin"."Window to Desktop 1" = "Meta+!,,Window to Desktop 1";
      #   "kwin"."Window to Desktop 10" = "none,,Window to Desktop 10";
      #   "kwin"."Window to Desktop 11" = "none,,Window to Desktop 11";
      #   "kwin"."Window to Desktop 12" = "none,,Window to Desktop 12";
      #   "kwin"."Window to Desktop 13" = "none,,Window to Desktop 13";
      #   "kwin"."Window to Desktop 14" = "none,,Window to Desktop 14";
      #   "kwin"."Window to Desktop 15" = "none,,Window to Desktop 15";
      #   "kwin"."Window to Desktop 16" = "none,,Window to Desktop 16";
      #   "kwin"."Window to Desktop 17" = "none,,Window to Desktop 17";
      #   "kwin"."Window to Desktop 18" = "none,,Window to Desktop 18";
      #   "kwin"."Window to Desktop 19" = "none,,Window to Desktop 19";
      #   "kwin"."Window to Desktop 2" = "Meta+@,,Window to Desktop 2";
      #   "kwin"."Window to Desktop 20" = "none,,Window to Desktop 20";
      #   "kwin"."Window to Desktop 3" = "Meta+#,,Window to Desktop 3";
      #   "kwin"."Window to Desktop 4" = "Meta+$,,Window to Desktop 4";
      #   "kwin"."Window to Desktop 5" = "Meta+%,,Window to Desktop 5";
      #   "kwin"."Window to Desktop 6" = "Meta+^,,Window to Desktop 6";
      #   "kwin"."Window to Desktop 7" = "Meta+&,,Window to Desktop 7";
      #   "kwin"."Window to Desktop 8" = "Meta+*,,Window to Desktop 8";
      #   "kwin"."Window to Desktop 9" = "Meta+(,,Window to Desktop 9";
      #   "kwin"."Window to Next Desktop" =
      #     "Meta+Shift+PgUp,,Window to Next Desktop";
      #   "kwin"."Window to Next Screen" =
      #     "none,Meta+Shift+Right,Move Window to Next Screen";
      #   "kwin"."Window to Previous Desktop" =
      #     "Meta+Shift+PgDown,,Window to Previous Desktop";
      #   "kwin"."Window to Previous Screen" =
      #     "none,Meta+Shift+Left,Move Window to Previous Screen";
      #   "kwin"."Window to Screen 0" = "none,,Move Window to Screen 0";
      #   "kwin"."Window to Screen 1" = "none,,Move Window to Screen 1";
      #   "kwin"."Window to Screen 2" = "none,,Move Window to Screen 2";
      #   "kwin"."Window to Screen 3" = "none,,Move Window to Screen 3";
      #   "kwin"."Window to Screen 4" = "none,,Move Window to Screen 4";
      #   "kwin"."Window to Screen 5" = "none,,Move Window to Screen 5";
      #   "kwin"."Window to Screen 6" = "none,,Move Window to Screen 6";
      #   "kwin"."Window to Screen 7" = "none,,Move Window to Screen 7";
      #   "kwin"."disableInputCapture" = "Meta+Shift+Esc";
      #   "kwin"."view_actual_size" = "Meta+0";
      #   "kwin"."view_zoom_in" = [ "Meta++" "Meta+=,Meta++" "Meta+=,Zoom In" ];
      #   "kwin"."view_zoom_out" = "Meta+-";
      #   "mediacontrol"."mediavolumedown" = "none,,Media volume down";
      #   "mediacontrol"."mediavolumeup" = "none,,Media volume up";
      #   "mediacontrol"."nextmedia" = "Media Next";
      #   "mediacontrol"."pausemedia" = "Media Pause";
      #   "mediacontrol"."playmedia" = "none,,Play media playback";
      #   "mediacontrol"."playpausemedia" = "Media Play";
      #   "mediacontrol"."previousmedia" = "Media Previous";
      #   "mediacontrol"."stopmedia" = "Media Stop";
      #   "org_kde_powerdevil"."Decrease Keyboard Brightness" =
      #     "Keyboard Brightness Down";
      #   "org_kde_powerdevil"."Decrease Screen Brightness" =
      #     "Monitor Brightness Down";
      #   "org_kde_powerdevil"."Decrease Screen Brightness Small" =
      #     "Shift+Monitor Brightness Down";
      #   "org_kde_powerdevil"."Hibernate" = "Hibernate";
      #   "org_kde_powerdevil"."Increase Keyboard Brightness" =
      #     "Keyboard Brightness Up";
      #   "org_kde_powerdevil"."Increase Screen Brightness" =
      #     "Monitor Brightness Up";
      #   "org_kde_powerdevil"."Increase Screen Brightness Small" =
      #     "Shift+Monitor Brightness Up";
      #   "org_kde_powerdevil"."PowerDown" = "Power Down";
      #   "org_kde_powerdevil"."PowerOff" = "Power Off";
      #   "org_kde_powerdevil"."Sleep" = "Sleep";
      #   "org_kde_powerdevil"."Toggle Keyboard Backlight" =
      #     "Keyboard Light On/Off";
      #   "org_kde_powerdevil"."Turn Off Screen" = [ ];
      #   "org_kde_powerdevil"."powerProfile" =
      #     [ "Battery" "Meta+B,Battery" "Meta+B,Switch Power Profile" ];
      #   "plasmashell"."activate application launcher" =
      #     [ "Meta" "Alt+F1,Meta" "Alt+F1,Activate Application Launcher" ];
      #   "plasmashell"."activate task manager entry 1" =
      #     "none,Meta+1,Activate Task Manager Entry 1";
      #   "plasmashell"."activate task manager entry 10" =
      #     "none,,Activate Task Manager Entry 10";
      #   "plasmashell"."activate task manager entry 2" =
      #     "none,Meta+2,Activate Task Manager Entry 2";
      #   "plasmashell"."activate task manager entry 3" =
      #     "none,Meta+3,Activate Task Manager Entry 3";
      #   "plasmashell"."activate task manager entry 4" =
      #     "none,Meta+4,Activate Task Manager Entry 4";
      #   "plasmashell"."activate task manager entry 5" =
      #     "none,Meta+5,Activate Task Manager Entry 5";
      #   "plasmashell"."activate task manager entry 6" =
      #     "none,Meta+6,Activate Task Manager Entry 6";
      #   "plasmashell"."activate task manager entry 7" =
      #     "none,Meta+7,Activate Task Manager Entry 7";
      #   "plasmashell"."activate task manager entry 8" =
      #     "none,Meta+8,Activate Task Manager Entry 8";
      #   "plasmashell"."activate task manager entry 9" =
      #     "none,Meta+9,Activate Task Manager Entry 9";
      #   "plasmashell"."clear-history" = "Meta+Shift+V,,Clear Clipboard History";
      #   "plasmashell"."clipboard_action" = "Meta+Ctrl+X";
      #   "plasmashell"."cycle-panels" = "Meta+Alt+P";
      #   "plasmashell"."cycleNextAction" = "none,,Next History Item";
      #   "plasmashell"."cyclePrevAction" = "none,,Previous History Item";
      #   "plasmashell"."manage activities" = "none,Meta+Q,Show Activity Switcher";
      #   "plasmashell"."next activity" = [ ];
      #   "plasmashell"."previous activity" = [ ];
      #   "plasmashell"."repeat_action" =
      #     "none,,Manually Invoke Action on Current Clipboard";
      #   "plasmashell"."show dashboard" = "Meta+F4,Ctrl+F12,Show Desktop";
      #   "plasmashell"."show-barcode" = "none,,Show Barcode…";
      #   "plasmashell"."show-on-mouse-pos" = "Meta+V";
      #   "plasmashell"."stop current activity" =
      #     "none,Meta+S,Stop Current Activity";
      #   "plasmashell"."switch to next activity" = "none,,Switch to Next Activity";
      #   "plasmashell"."switch to previous activity" =
      #     "none,,Switch to Previous Activity";
      #   "plasmashell"."toggle do not disturb" =
      #     "Meta+Shift+N,,Toggle do not disturb";
      #   "services/net.local.eww.desktop"."_launch" = "Meta+F11";
      # };

      # configFile = {
      #   "baloofilerc"."General"."dbVersion" = 2;
      #   "baloofilerc"."General"."exclude filters" =
      #     "*~,*.part,*.o,*.la,*.lo,*.loT,*.moc,moc_*.cpp,qrc_*.cpp,ui_*.h,cmake_install.cmake,CMakeCache.txt,CTestTestfile.cmake,libtool,config.status,confdefs.h,autom4te,conftest,confstat,Makefile.am,*.gcode,.ninja_deps,.ninja_log,build.ninja,*.csproj,*.m4,*.rej,*.gmo,*.pc,*.omf,*.aux,*.tmp,*.po,*.vm*,*.nvram,*.rcore,*.swp,*.swap,lzo,litmain.sh,*.orig,.histfile.*,.xsession-errors*,*.map,*.so,*.a,*.db,*.qrc,*.ini,*.init,*.img,*.vdi,*.vbox*,vbox.log,*.qcow2,*.vmdk,*.vhd,*.vhdx,*.sql,*.sql.gz,*.ytdl,*.tfstate*,*.class,*.pyc,*.pyo,*.elc,*.qmlc,*.jsc,*.fastq,*.fq,*.gb,*.fasta,*.fna,*.gbff,*.faa,po,CVS,.svn,.git,_darcs,.bzr,.hg,CMakeFiles,CMakeTmp,CMakeTmpQmake,.moc,.obj,.pch,.uic,.npm,.yarn,.yarn-cache,__pycache__,node_modules,node_packages,nbproject,.terraform,.venv,venv,core-dumps,lost+found";
      #   "baloofilerc"."General"."exclude filters version" = 9;
      #   "dolphinrc"."ContentDisplay"."UseShortRelativeDates" = false;
      #   "dolphinrc"."DetailsMode"."PreviewSize" = 22;
      #   "dolphinrc"."ExtractDialog"."2048x1152 screen: Height" = 576;
      #   "dolphinrc"."ExtractDialog"."2048x1152 screen: Width" = 1320;
      #   "dolphinrc"."ExtractDialog"."DirHistory[$e]" = "$HOME/Applications/";
      #   "dolphinrc"."General"."BrowseThroughArchives" = true;
      #   "dolphinrc"."General"."ShowFullPath" = true;
      #   "dolphinrc"."General"."UseTabForSwitchingSplitView" = true;
      #   "dolphinrc"."General"."ViewPropsTimestamp" = "2025,2,12,19,7,30.472";
      #   "dolphinrc"."InformationPanel"."dateFormat" = "ShortFormat";
      #   "dolphinrc"."KFileDialog Settings"."Places Icons Auto-resize" = false;
      #   "dolphinrc"."KFileDialog Settings"."Places Icons Static Size" = 22;
      #   "dolphinrc"."PreviewSettings"."Plugins" =
      #     "appimagethumbnail,audiothumbnail,blenderthumbnail,comicbookthumbnail,cursorthumbnail,djvuthumbnail,ebookthumbnail,exrthumbnail,directorythumbnail,fontthumbnail,imagethumbnail,calligraimagethumbnail,jpegthumbnail,kraorathumbnail,windowsexethumbnail,windowsimagethumbnail,mobithumbnail,opendocumentthumbnail,calligrathumbnail,gsthumbnail,rawthumbnail,svgthumbnail,ffmpegthumbs";
      #   "dolphinrc"."Search"."Location" = "Everywhere";
      #   "dolphinrc"."VersionControl"."enabledPlugins" = "Git";
      #   "kactivitymanagerdrc"."activities"."62a560c1-414c-48e4-b51c-0b5b77c69eef" =
      #     "Do not track me";
      #   "kactivitymanagerdrc"."activities"."775e9937-87ae-430c-927b-5e2e1d8cbcf1" =
      #     "Default";
      #   "kactivitymanagerdrc"."activities"."c3b67045-c8a8-4648-976f-68be603203d8" =
      #     "Caffeine";
      #   "kactivitymanagerdrc"."activities-descriptions"."c3b67045-c8a8-4648-976f-68be603203d8" =
      #     "Moscow never sleeps";
      #   "kactivitymanagerdrc"."activities-icons"."62a560c1-414c-48e4-b51c-0b5b77c69eef" =
      #     "view-private";
      #   "kactivitymanagerdrc"."activities-icons"."775e9937-87ae-430c-927b-5e2e1d8cbcf1" =
      #     "folder-windows-symbolic";
      #   "kactivitymanagerdrc"."activities-icons"."c3b67045-c8a8-4648-976f-68be603203d8" =
      #     "accept_time_event";
      #   "kactivitymanagerdrc"."main"."currentActivity" =
      #     "775e9937-87ae-430c-927b-5e2e1d8cbcf1";
      #   "kded5rc"."Module-browserintegrationreminder"."autoload" = false;
      #   "kded5rc"."Module-device_automounter"."autoload" = false;
      #   "kdeglobals"."DirSelect Dialog"."DirSelectDialog Size" = "862,591";
      #   "kdeglobals"."General"."LastUsedCustomAccentColor" = "146,110,228";
      #   "kdeglobals"."General"."UseSystemBell" = true;
      #   "kdeglobals"."General"."XftHintStyle" = "hintslight";
      #   "kdeglobals"."General"."XftSubPixel" = "rgb";
      #   "kdeglobals"."KDE"."ShowDeleteCommand" = false;
      #   "kdeglobals"."KDE"."widgetStyle" = "Breeze";
      #   "kdeglobals"."KFileDialog Settings"."Allow Expansion" = false;
      #   "kdeglobals"."KFileDialog Settings"."Automatically select filename extension" =
      #     true;
      #   "kdeglobals"."KFileDialog Settings"."Breadcrumb Navigation" = true;
      #   "kdeglobals"."KFileDialog Settings"."Decoration position" = 2;
      #   "kdeglobals"."KFileDialog Settings"."LocationCombo Completionmode" = 5;
      #   "kdeglobals"."KFileDialog Settings"."PathCombo Completionmode" = 5;
      #   "kdeglobals"."KFileDialog Settings"."Show Bookmarks" = false;
      #   "kdeglobals"."KFileDialog Settings"."Show Full Path" = false;
      #   "kdeglobals"."KFileDialog Settings"."Show Inline Previews" = true;
      #   "kdeglobals"."KFileDialog Settings"."Show Preview" = false;
      #   "kdeglobals"."KFileDialog Settings"."Show Speedbar" = true;
      #   "kdeglobals"."KFileDialog Settings"."Show hidden files" = true;
      #   "kdeglobals"."KFileDialog Settings"."Sort by" = "Name";
      #   "kdeglobals"."KFileDialog Settings"."Sort directories first" = true;
      #   "kdeglobals"."KFileDialog Settings"."Sort hidden files last" = false;
      #   "kdeglobals"."KFileDialog Settings"."Sort reversed" = false;
      #   "kdeglobals"."KFileDialog Settings"."Speedbar Width" = 270;
      #   "kdeglobals"."KFileDialog Settings"."View Style" = "DetailTree";
      #   "kdeglobals"."KShortcutsDialog Settings"."Dialog Size" = "902,480";
      #   "kdeglobals"."PreviewSettings"."EnableRemoteFolderThumbnail" = false;
      #   "kdeglobals"."PreviewSettings"."MaximumRemoteSize" = 0;
      #   "kdeglobals"."WM"."activeBackground" = "30,30,46";
      #   "kdeglobals"."WM"."activeBlend" = "205,214,244";
      #   "kdeglobals"."WM"."activeFont" =
      #     "Noto Sans,11,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
      #   "kdeglobals"."WM"."activeForeground" = "205,214,244";
      #   "kdeglobals"."WM"."inactiveBackground" = "17,17,27";
      #   "kdeglobals"."WM"."inactiveBlend" = "166,173,200";
      #   "kdeglobals"."WM"."inactiveForeground" = "166,173,200";
      #   "kiorc"."Confirmations"."ConfirmDelete" = true;
      #   "kiorc"."Confirmations"."ConfirmEmptyTrash" = true;
      #   "kiorc"."Confirmations"."ConfirmTrash" = false;
      #   "kiorc"."Executable scripts"."behaviourOnLaunch" = "execute";
      #   "kscreenlockerrc"."Greeter/Wallpaper/org.kde.image/General"."Image" =
      #     "/home/drakolis/Pictures/shaded_landscape.png";
      #   "kscreenlockerrc"."Greeter/Wallpaper/org.kde.image/General"."PreviewImage" =
      #     "/home/drakolis/Pictures/shaded_landscape.png";
      #   "kservicemenurc"."Show"."Play" = true;
      #   "kservicemenurc"."Show"."Print" = true;
      #   "kservicemenurc"."Show"."compressfileitemaction" = true;
      #   "kservicemenurc"."Show"."decrypt-view" = true;
      #   "kservicemenurc"."Show"."encrypt" = true;
      #   "kservicemenurc"."Show"."extractfileitemaction" = true;
      #   "kservicemenurc"."Show"."forgetfileitemaction" = true;
      #   "kservicemenurc"."Show"."installFont" = true;
      #   "kservicemenurc"."Show"."kactivitymanagerd_fileitem_linking_plugin" =
      #     true;
      #   "kservicemenurc"."Show"."kdeconnectfileitemaction" = true;
      #   "kservicemenurc"."Show"."kio-admin" = false;
      #   "kservicemenurc"."Show"."kompare" = true;
      #   "kservicemenurc"."Show"."makefileactions" = true;
      #   "kservicemenurc"."Show"."mountisoaction" = true;
      #   "kservicemenurc"."Show"."movetonewfolderitemaction" = true;
      #   "kservicemenurc"."Show"."runInKonsole" = true;
      #   "kservicemenurc"."Show"."slideshowfileitemaction" = true;
      #   "kservicemenurc"."Show"."tagsfileitemaction" = true;
      #   "kservicemenurc"."Show"."wallpaperfileitemaction" = true;
      #   "ktrashrc"."\\/home\\/drakolis\\/.local\\/share\\/Trash"."Days" = 7;
      #   "ktrashrc"."\\/home\\/drakolis\\/.local\\/share\\/Trash"."LimitReachedAction" =
      #     0;
      #   "ktrashrc"."\\/home\\/drakolis\\/.local\\/share\\/Trash"."Percent" = 10;
      #   "ktrashrc"."\\/home\\/drakolis\\/.local\\/share\\/Trash"."UseSizeLimit" =
      #     true;
      #   "ktrashrc"."\\/home\\/drakolis\\/.local\\/share\\/Trash"."UseTimeLimit" =
      #     false;
      #   "kuriikwsfilterrc"."General"."DefaultWebShortcut" = "ecosia";
      #   "kuriikwsfilterrc"."General"."EnableWebShortcuts" = true;
      #   "kuriikwsfilterrc"."General"."KeywordDelimiter" = "s";
      #   "kuriikwsfilterrc"."General"."PreferredWebShortcuts" =
      #     "youtube,wikit,yahoo,wikipedia,google";
      #   "kuriikwsfilterrc"."General"."UsePreferredWebShortcutsOnly" = false;
      #   "kwinrc"."Activities/LastVirtualDesktop"."775e9937-87ae-430c-927b-5e2e1d8cbcf1" =
      #     "3294c513-c549-45ad-b580-f60416ffc28b";
      #   "kwinrc"."Desktops"."Id_1" = "3294c513-c549-45ad-b580-f60416ffc28b";
      #   "kwinrc"."Desktops"."Id_2" = "078b1dae-9d02-4b9b-91fa-e76351a29f42";
      #   "kwinrc"."Desktops"."Id_3" = "dae978f1-3845-4fdf-9764-cd896ae30adf";
      #   "kwinrc"."Desktops"."Id_4" = "ec5b46d0-727c-49f0-a675-97996b833647";
      #   "kwinrc"."Desktops"."Id_5" = "c1de60fa-22c2-4595-99f3-9ebd9b626a1e";
      #   "kwinrc"."Desktops"."Id_6" = "3657f97b-52fa-42a7-acb3-1900e92a4f8b";
      #   "kwinrc"."Desktops"."Id_7" = "d346e097-7051-4092-8a43-74874fe0c119";
      #   "kwinrc"."Desktops"."Id_8" = "dc8cb509-aa2f-4520-be22-a810ebd33b42";
      #   "kwinrc"."Desktops"."Id_9" = "05ca34ee-098c-48e2-97d2-543369427d79";
      #   "kwinrc"."Desktops"."Number" = 9;
      #   "kwinrc"."Desktops"."Rows" = 3;
      #   "kwinrc"."Effect-diminactive"."Strength" = 15;
      #   "kwinrc"."ElectricBorders"."BottomLeft" = "ActivityManager";
      #   "kwinrc"."MouseBindings"."CommandAllWheel" = "Change Opacity";
      #   "kwinrc"."MouseBindings"."CommandTitlebarWheel" = "Change Opacity";
      #   "kwinrc"."NightColor"."Active" = true;
      #   "kwinrc"."NightColor"."LatitudeFixed" = 50.81811874075401;
      #   "kwinrc"."NightColor"."LongitudeFixed" = 9.902440670458418;
      #   "kwinrc"."NightColor"."Mode" = "Location";
      #   "kwinrc"."Plugins"."dimscreenEnabled" = true;
      #   "kwinrc"."Plugins"."translucencyEnabled" = true;
      #   "kwinrc"."Tiling"."padding" = 4;
      #   "kwinrc"."Tiling/1b3238a9-4fc7-5648-a465-579b34cbd119"."tiles" = ''
      #     {"layoutDirection":"horizontal","tiles":[{"width":0.623046875},{"width":0.376953125}]}'';
      #   "kwinrc"."Tiling/92e842d7-5928-5c43-884a-4912e7cc82ed"."tiles" = ''
      #     {"layoutDirection":"horizontal","tiles":[{"width":0.25},{"width":0.5},{"width":0.25}]}'';
      #   "kwinrc"."Tiling/9c6e6cfe-e7d1-53ba-a5bf-51c18c5c98d2"."tiles" = ''
      #     {"layoutDirection":"horizontal","tiles":[{"width":0.5143554687499999},{"width":0.48564453125000007}]}'';
      #   "kwinrc"."Wayland"."VirtualKeyboardEnabled" = true;
      #   "kwinrc"."Windows"."MaximizeButtonMiddleClickCommand" =
      #     "Maximize (horizontal only)";
      #   "kwinrc"."Windows"."MaximizeButtonRightClickCommand" =
      #     "Maximize (vertical only)";
      #   "kwinrc"."Xwayland"."Scale" = 1;
      #   "kwinrc"."org.kde.kdecoration2"."theme" = "Breeze";
      # };
      # dataFile = {
      #   "kate/anonymous.katesession"."Document 0"."URL" =
      #     "file:///home/drakolis/.config/sops/age/keys.txt";
      #   "kate/anonymous.katesession"."Kate Plugins"."cmaketoolsplugin" = false;
      #   "kate/anonymous.katesession"."Kate Plugins"."compilerexplorer" = false;
      #   "kate/anonymous.katesession"."Kate Plugins"."eslintplugin" = true;
      #   "kate/anonymous.katesession"."Kate Plugins"."externaltoolsplugin" = true;
      #   "kate/anonymous.katesession"."Kate Plugins"."formatplugin" = true;
      #   "kate/anonymous.katesession"."Kate Plugins"."katebacktracebrowserplugin" =
      #     false;
      #   "kate/anonymous.katesession"."Kate Plugins"."katebuildplugin" = true;
      #   "kate/anonymous.katesession"."Kate Plugins"."katecloseexceptplugin" =
      #     false;
      #   "kate/anonymous.katesession"."Kate Plugins"."katecolorpickerplugin" =
      #     true;
      #   "kate/anonymous.katesession"."Kate Plugins"."katectagsplugin" = true;
      #   "kate/anonymous.katesession"."Kate Plugins"."katefilebrowserplugin" =
      #     false;
      #   "kate/anonymous.katesession"."Kate Plugins"."katefiletreeplugin" = true;
      #   "kate/anonymous.katesession"."Kate Plugins"."kategdbplugin" = false;
      #   "kate/anonymous.katesession"."Kate Plugins"."kategitblameplugin" = true;
      #   "kate/anonymous.katesession"."Kate Plugins"."katekonsoleplugin" = true;
      #   "kate/anonymous.katesession"."Kate Plugins"."kateprojectplugin" = true;
      #   "kate/anonymous.katesession"."Kate Plugins"."katereplicodeplugin" = false;
      #   "kate/anonymous.katesession"."Kate Plugins"."katesearchplugin" = true;
      #   "kate/anonymous.katesession"."Kate Plugins"."katesnippetsplugin" = false;
      #   "kate/anonymous.katesession"."Kate Plugins"."katesqlplugin" = false;
      #   "kate/anonymous.katesession"."Kate Plugins"."katesymbolviewerplugin" =
      #     false;
      #   "kate/anonymous.katesession"."Kate Plugins"."katexmlcheckplugin" = false;
      #   "kate/anonymous.katesession"."Kate Plugins"."katexmltoolsplugin" = false;
      #   "kate/anonymous.katesession"."Kate Plugins"."keyboardmacrosplugin" =
      #     false;
      #   "kate/anonymous.katesession"."Kate Plugins"."ktexteditorpreviewplugin" =
      #     false;
      #   "kate/anonymous.katesession"."Kate Plugins"."latexcompletionplugin" =
      #     false;
      #   "kate/anonymous.katesession"."Kate Plugins"."lspclientplugin" = true;
      #   "kate/anonymous.katesession"."Kate Plugins"."openlinkplugin" = false;
      #   "kate/anonymous.katesession"."Kate Plugins"."rainbowparens" = true;
      #   "kate/anonymous.katesession"."Kate Plugins"."rbqlplugin" = false;
      #   "kate/anonymous.katesession"."Kate Plugins"."tabswitcherplugin" = true;
      #   "kate/anonymous.katesession"."Kate Plugins"."textfilterplugin" = true;
      #   "kate/anonymous.katesession"."MainWindow0"."Active ViewSpace" = 0;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-H-Splitter" =
      #     "0,1249,0";
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-0-Bar-0-TvList" =
      #     "";
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-0-LastSize" =
      #     258;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-0-SectSizes" =
      #     0;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-0-Splitter" =
      #     1246;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-1-Bar-0-TvList" =
      #     "kateproject,kateprojectgit,lspclient_symbol_outline,kate_private_plugin_katefiletreeplugin";
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-1-LastSize" =
      #     269;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-1-SectSizes" =
      #     0;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-1-Splitter" =
      #     1246;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-2-Bar-0-TvList" =
      #     "";
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-2-LastSize" =
      #     200;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-2-SectSizes" =
      #     0;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-2-Splitter" =
      #     1249;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-3-Bar-0-TvList" =
      #     "output,diagnostics,kate_plugin_katesearch,kateprojectinfo,kate_private_plugin_katekonsoleplugin,kate_plugin_katebuildplugin,kate_plugin_katectagsplugin";
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-3-LastSize" =
      #     462;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-3-SectSizes" =
      #     0;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-3-Splitter" =
      #     894;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-Style" = 2;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-Visible" =
      #     true;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-diagnostics-Position" =
      #     3;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-diagnostics-Show-Button-In-Sidebar" =
      #     true;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-diagnostics-Visible" =
      #     false;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_plugin_katebuildplugin-Position" =
      #     3;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_plugin_katebuildplugin-Show-Button-In-Sidebar" =
      #     true;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_plugin_katebuildplugin-Visible" =
      #     false;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_plugin_katectagsplugin-Position" =
      #     3;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_plugin_katectagsplugin-Show-Button-In-Sidebar" =
      #     true;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_plugin_katectagsplugin-Visible" =
      #     false;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_plugin_katesearch-Position" =
      #     3;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_plugin_katesearch-Show-Button-In-Sidebar" =
      #     true;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_plugin_katesearch-Visible" =
      #     false;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_private_plugin_katefiletreeplugin-Position" =
      #     1;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_private_plugin_katefiletreeplugin-Show-Button-In-Sidebar" =
      #     true;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_private_plugin_katefiletreeplugin-Visible" =
      #     false;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_private_plugin_katekonsoleplugin-Position" =
      #     3;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_private_plugin_katekonsoleplugin-Show-Button-In-Sidebar" =
      #     true;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_private_plugin_katekonsoleplugin-Visible" =
      #     false;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateproject-Position" =
      #     1;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateproject-Show-Button-In-Sidebar" =
      #     true;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateproject-Visible" =
      #     false;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateprojectgit-Position" =
      #     1;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateprojectgit-Show-Button-In-Sidebar" =
      #     true;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateprojectgit-Visible" =
      #     false;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateprojectinfo-Position" =
      #     3;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateprojectinfo-Show-Button-In-Sidebar" =
      #     true;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateprojectinfo-Visible" =
      #     false;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-lspclient_symbol_outline-Position" =
      #     1;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-lspclient_symbol_outline-Show-Button-In-Sidebar" =
      #     true;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-lspclient_symbol_outline-Visible" =
      #     false;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-output-Position" =
      #     3;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-output-Show-Button-In-Sidebar" =
      #     true;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-output-Visible" =
      #     false;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-V-Splitter" =
      #     "0,1246,0";
      #   "kate/anonymous.katesession"."MainWindow0 Settings"."WindowState" = 8;
      #   "kate/anonymous.katesession"."MainWindow0-Splitter 0"."Children" =
      #     "MainWindow0-ViewSpace 0";
      #   "kate/anonymous.katesession"."MainWindow0-Splitter 0"."Orientation" = 1;
      #   "kate/anonymous.katesession"."MainWindow0-Splitter 0"."Sizes" = 1249;
      #   "kate/anonymous.katesession"."MainWindow0-ViewSpace 0"."Active View" = 0;
      #   "kate/anonymous.katesession"."MainWindow0-ViewSpace 0"."Count" = 1;
      #   "kate/anonymous.katesession"."MainWindow0-ViewSpace 0"."Documents" = 0;
      #   "kate/anonymous.katesession"."MainWindow0-ViewSpace 0"."View 0" = 0;
      #   "kate/anonymous.katesession"."MainWindow0-ViewSpace 0 0"."CursorColumn" =
      #     0;
      #   "kate/anonymous.katesession"."MainWindow0-ViewSpace 0 0"."CursorLine" = 3;
      #   "kate/anonymous.katesession"."Open Documents"."Count" = 1;
      #   "kate/anonymous.katesession"."Open MainWindows"."Count" = 1;
      #   "kate/anonymous.katesession"."Plugin:katebuildplugin:MainWindow:0"."NumTargets" =
      #     0;
      #   "kate/anonymous.katesession"."Plugin:katebuildplugin:MainWindow:0"."ProjectTargetSetRow" =
      #     1;
      #   "kate/anonymous.katesession"."Plugin:katectagsplugin:MainWindow:0"."SessionDatabase" =
      #     "";
      #   "kate/anonymous.katesession"."Plugin:katectagsplugin:MainWindow:0"."SessionNumTargets" =
      #     0;
      #   "kate/anonymous.katesession"."Plugin:katectagsplugin:MainWindow:0"."TagsGenCMD" =
      #     "ctags -R --c++-types=+px --extra=+q --excmd=pattern --exclude=Makefile --exclude=.";
      #   "kate/anonymous.katesession"."Plugin:kateprojectplugin:"."projects" = "";
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."BinaryFiles" =
      #     false;
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."CurrentExcludeFilter" =
      #     "-1";
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."CurrentFilter" =
      #     "-1";
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."ExcludeFilters" =
      #     "";
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."ExpandSearchResults" =
      #     false;
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."Filters" =
      #     "";
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."FollowSymLink" =
      #     false;
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."HiddenFiles" =
      #     false;
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."MatchCase" =
      #     false;
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."Place" =
      #     1;
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."Recursive" =
      #     true;
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."Replaces" =
      #     "";
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."Search" =
      #     "";
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SearchAsYouTypeAllProjects" =
      #     true;
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SearchAsYouTypeCurrentFile" =
      #     true;
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SearchAsYouTypeFolder" =
      #     true;
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SearchAsYouTypeOpenFiles" =
      #     true;
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SearchAsYouTypeProject" =
      #     true;
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SearchDiskFiles" =
      #     "";
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SearchDiskFiless" =
      #     "";
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SizeLimit" =
      #     128;
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."UseRegExp" =
      #     false;
      # };
    };
  };
}
