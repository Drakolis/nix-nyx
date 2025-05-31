{
  programs.plasma = {
    shortcuts = {
      "services/net.local.kget.desktop"."_launch" = "Meta+Alt+V";

      "services/org.kde.CrowTranslate.desktop" = {
        "TranslateSelectedText" = "Meta+C";
        "TranslateScreenArea" = "Meta+Shift+C";
        "SpeakTranslatedSelection" = "Meta+Alt+C";
        "SpeakSelection" = "Meta+Alt+Shift+C";

        "CopyTranslatedSelection" = "";
        "Open" = "Meta+Ctrl+C";
        "RecognizeScreenArea" = "";
        "StopSpeaking" = "Meta+Ctrl+Shift+C";
      };

      "services/org.kde.dolphin.desktop"."_launch" = "Meta+Z";

      "services/org.kde.konsole.desktop"."_launch" = "Meta+Return";

      "services/org.kde.plasma.emojier.desktop"."_launch" = "Meta+.";

      "services/org.kde.kcalc.desktop"."_launch" = "Calculator";

      "services/org.kde.plasma-systemmonitor.desktop"."_launch" = "Meta+Esc";

      "services/element-desktop.desktop"."_launch" = "Meta+X";

      yakuake.toggle-window-state = "Meta+F12";

      "ktorrent" = {
        "queue_suspend" = "Meta+Shift+O";
        "show_kt" = "Meta+O";
      };

      kcm_touchpad = {
        "Disable Touchpad" = "Touchpad Off";
        "Enable Touchpad" = "Touchpad On";
        "Toggle Touchpad" = "Touchpad Toggle";
      };

      kmix = {
        decrease_microphone_volume = [
          "Microphone Volume Down"
          "Meta+Volume Down"
        ];
        decrease_volume = "Volume Down";
        decrease_volume_small = "Shift+Volume Down";
        increase_microphone_volume = [
          "Microphone Volume Up"
          "Meta+Volume Up"
        ];
        increase_volume = "Volume Up";
        increase_volume_small = "Shift+Volume Up";
        mic_mute = [
          "Microphone Mute"
          "Meta+Volume Mute"
        ];
        mute = "Volume Mute";
      };

      mediacontrol = {
        mediavolumedown = "";
        mediavolumeup = "";
        nextmedia = "Media Next";
        pausemedia = "Media Pause";
        playmedia = "";
        playpausemedia = "Media Play";
        previousmedia = "Media Previous";
        stopmedia = "Media Stop";
      };

      plasmashell = {
        "manage activities" = "Meta+Ctrl+A";
        "stop current activity" = "Meta+Ctrl+Q";
        "next activity" = "Meta+Ctrl+Tab";
        "previous activity" = "Meta+Ctrl+Shift+Tab";
        "switch to next activity" = "Meta+Ctrl+Tab";
        "switch to previous activity" = "Meta+Ctrl+Shift+Tab";

        # Clipboard manager
        "show-on-mouse-pos" = "Meta+V";
        "clear-history" = "Meta+Shift+V";
        "clipboard_action" = "";
        "cycleNextAction" = ""; # ???
        "cyclePrevAction" = ""; # ???
        "repeat_action" = "";
        "show-barcode" = ""; # Shows QR code??

        # Global Desktop Commands
        "activate application launcher" = "Meta";
        "cycle-panels" = "Meta+Alt+P";
        "show dashboard" = "Meta+F4"; # Show desktop
        "toggle do not disturb" = "Meta+Shift+N";

        # Task Manager
        "activate task manager entry 1" = "";
        "activate task manager entry 2" = "";
        "activate task manager entry 3" = "";
        "activate task manager entry 4" = "";
        "activate task manager entry 5" = "";
        "activate task manager entry 6" = "";
        "activate task manager entry 7" = "";
        "activate task manager entry 8" = "";
        "activate task manager entry 9" = "";
        "activate task manager entry 10" = "";
      };

      kwin = {
        # Desktop
        "Grid View" = "Meta+G";
        "Show Desktop" = "Meta+D";
        "Overview" = "Meta+F3";
        "MoveMouseToCenter" = "Meta+F6";
        "MoveMouseToFocus" = "Meta+F5";
        "ExposeClass" = "Meta+F7";
        "ExposeClassCurrentDesktop" = "";
        "Expose" = "Meta+F9";
        "ExposeAll" = "Meta+F10";
        "Toggle Night Color" = "";
        "Activate Window Demanding Attention" = "Meta+Ctrl+A";
        "disableInputCapture" = "Meta+Shift+Esc";
        "Cycle Overview" = "";
        "Cycle Overview Opposite" = "";
        "Move Tablet to Next Output" = "";

        # Zooming
        "view_actual_size" = "Meta+0";
        "view_zoom_in" = "Meta++";
        "view_zoom_out" = "Meta+-";
        "MoveZoomDown" = "";
        "MoveZoomLeft" = "";
        "MoveZoomRight" = "";
        "MoveZoomUp" = "";

        # Window Control
        "Window Operations Menu" = "";
        "Kill Window" = "Meta+Shift+Q";
        "Window Close" = "Meta+Q";
        "Window Minimize" = "Meta+W";
        "Window Maximize" = "Meta+F";
        "Window Maximize Horizontal" = "";
        "Window Maximize Vertical" = "";
        "Window Fullscreen" = "Meta+F11";
        "Window Shade" = "";
        "Window No Border" = "";
        "Window On All Desktops" = "";
        "Toggle Window Raise/Lower" = "";
        "Window Raise" = "";
        "Window Lower" = "";

        # Window Resize
        "Window Resize" = "";
        "Window Shrink Horizontal" = "";
        "Window Shrink Vertical" = "";
        "Window Grow Horizontal" = "";
        "Window Grow Vertical" = "";

        # Window Position
        "Window Move" = "";
        "Window Move Center" = "";
        "Window Pack Down" = "";
        "Window Pack Left" = "";
        "Window Pack Right" = "";
        "Window Pack Up" = "";
        "Window Above Other Windows" = "";
        "Window Below Other Windows" = "";

        # Window Other
        "Setup Window Shortcut" = ""; # ???
        "Decrease Opacity" = "";
        "Increase Opacity" = "";

        # Window chooser
        "Walk Through Windows" = "Meta+Tab";
        "Walk Through Windows (Reverse)" = "Meta+Shift+Tab";
        "Walk Through Windows Alternative" = "";
        "Walk Through Windows Alternative (Reverse)" = "";
        "Walk Through Windows of Current Application" = "Meta+`";
        "Walk Through Windows of Current Application (Reverse)" = "Meta+~";
        "Walk Through Windows of Current Application Alternative" = "";
        "Walk Through Windows of Current Application Alternative (Reverse)" = "";

        # Tiling
        "Edit Tiles" = "Meta+T";
        "Switch Window Down" = "Meta+Alt+Down";
        "Switch Window Left" = "Meta+Alt+Left";
        "Switch Window Right" = "Meta+Alt+Right";
        "Switch Window Up" = "Meta+Alt+Up";
        "Window Custom Quick Tile Bottom" = "Meta+Shift+Down";
        "Window Custom Quick Tile Left" = "Meta+Shift+Left";
        "Window Custom Quick Tile Right" = "Meta+Shift+Right";
        "Window Custom Quick Tile Top" = "Meta+Shift+Up";
        "Window Quick Tile Bottom" = "Meta+Down";
        "Window Quick Tile Bottom Left" = "";
        "Window Quick Tile Bottom Right" = "";
        "Window Quick Tile Left" = "Meta+Left";
        "Window Quick Tile Right" = "Meta+Right";
        "Window Quick Tile Top" = "Meta+Up";
        "Window Quick Tile Top Left" = "";
        "Window Quick Tile Top Right" = "";

        # Desktops: Switch
        "Switch One Desktop Down" = "";
        "Switch One Desktop Up" = "";
        "Switch One Desktop to the Left" = "";
        "Switch One Desktop to the Right" = "";
        "Switch to Next Desktop" = "Meta+PgUp";
        "Switch to Previous Desktop" = "Meta+PgDown";
        "Switch to Desktop 1" = "Meta+1";
        "Switch to Desktop 2" = "Meta+2";
        "Switch to Desktop 3" = "Meta+3";
        "Switch to Desktop 4" = "Meta+4";
        "Switch to Desktop 5" = "Meta+5";
        "Switch to Desktop 6" = "Meta+6";
        "Switch to Desktop 7" = "Meta+7";
        "Switch to Desktop 8" = "Meta+8";
        "Switch to Desktop 9" = "Meta+9";
        "Switch to Desktop 10" = "";
        "Switch to Desktop 11" = "";
        "Switch to Desktop 12" = "";
        "Switch to Desktop 13" = "";
        "Switch to Desktop 14" = "";
        "Switch to Desktop 15" = "";
        "Switch to Desktop 16" = "";
        "Switch to Desktop 17" = "";
        "Switch to Desktop 18" = "";
        "Switch to Desktop 19" = "";
        "Switch to Desktop 20" = "";

        # Desktops: Move Window
        "Window One Desktop Down" = "";
        "Window One Desktop Up" = "";
        "Window One Desktop to the Left" = "";
        "Window One Desktop to the Right" = "";
        "Window to Next Desktop" = "Meta+Shift+PgUp";
        "Window to Previous Desktop" = "Meta+Shift+PgDown";
        "Window to Desktop 1" = "Meta+!";
        "Window to Desktop 2" = "Meta+@";
        "Window to Desktop 3" = "Meta+#";
        "Window to Desktop 4" = "Meta+$";
        "Window to Desktop 5" = "Meta+%";
        "Window to Desktop 6" = "Meta+^";
        "Window to Desktop 7" = "Meta+&";
        "Window to Desktop 8" = "Meta+*";
        "Window to Desktop 9" = "Meta+(";
        "Window to Desktop 10" = "";
        "Window to Desktop 11" = "";
        "Window to Desktop 12" = "";
        "Window to Desktop 13" = "";
        "Window to Desktop 14" = "";
        "Window to Desktop 15" = "";
        "Window to Desktop 16" = "";
        "Window to Desktop 17" = "";
        "Window to Desktop 18" = "";
        "Window to Desktop 19" = "";
        "Window to Desktop 20" = "";

        # Screens: Switch
        "Switch to Screen Above" = "";
        "Switch to Screen Below" = "";
        "Switch to Screen to the Left" = "";
        "Switch to Screen to the Right" = "";
        "Switch to Previous Screen" = "";
        "Switch to Next Screen" = "";
        "Switch to Screen 0" = "";
        "Switch to Screen 1" = "";
        "Switch to Screen 2" = "";
        "Switch to Screen 3" = "";
        "Switch to Screen 4" = "";
        "Switch to Screen 5" = "";
        "Switch to Screen 6" = "";
        "Switch to Screen 7" = "";

        # Screens: Move Window
        "Window One Screen Down" = "";
        "Window One Screen Up" = "";
        "Window One Screen to the Left" = "";
        "Window One Screen to the Right" = "";
        "Window to Previous Screen" = "";
        "Window to Next Screen" = "";
        "Window to Screen 0" = "";
        "Window to Screen 1" = "";
        "Window to Screen 2" = "";
        "Window to Screen 3" = "";
        "Window to Screen 4" = "";
        "Window to Screen 5" = "";
        "Window to Screen 6" = "";
        "Window to Screen 7" = "";
      };

      ksmserver = {
        "Halt Without Confirmation" = "";
        "Lock Session" = "Meta+L";
        "Log Out" = "";
        "Log Out Without Confirmation" = "Ctrl+Alt+Del";
        "LogOut" = "";
        "Reboot" = "";
        "Reboot Without Confirmation" = "";
        "Shut Down" = "";
      };

      org_kde_powerdevil = {
        "PowerOff" = "Power Off";
        "PowerDown" = "Power Down";
        "Hibernate" = "Hibernate";
        "Sleep" = "Sleep";

        "Toggle Keyboard Backlight" = "Keyboard Light On/Off";
        "Decrease Keyboard Brightness" = "Keyboard Brightness Down";
        "Increase Keyboard Brightness" = "Keyboard Brightness Up";

        "Turn Off Screen" = "";
        "Decrease Screen Brightness" = "Monitor Brightness Down";
        "Increase Screen Brightness" = "Monitor Brightness Up";
        "Decrease Screen Brightness Small" = "Shift+Monitor Brightness Down";
        "Increase Screen Brightness Small" = "Shift+Monitor Brightness Up";

        "powerProfile" = "Meta+B";
      };
    };
  };
}
