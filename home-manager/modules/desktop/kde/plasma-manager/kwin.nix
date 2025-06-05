{
  programs.plasma = {
    kwin = {
      borderlessMaximizedWindows = false;

      cornerBarrier = false;
      edgeBarrier = 50;

      effects = {
        dimAdminMode.enable = true;
        dimInactive.enable = false;
        shakeCursor.enable = true;

        # POWER
        fps.enable = false; # true
        blur.enable = true; # false
        desktopSwitching.animation = "slide"; # "off"
        minimization.animation = "squash"; # "off"
        windowOpenClose.animation = "glide"; # "off"
        wobblyWindows.enable = true; # false
      };

      nightLight = {
        enable = true;
        mode = "location";
        location.latitude = "52.461078";
        location.longitude = "13.364068";
        temperature.day = 6500;
        temperature.night = 4500;
      };

      titlebarButtons = {
        left = [
          "on-all-desktops"
          "keep-above-windows"
        ];
        right = [
          "help"
          "minimize"
          "maximize"
          "close"
        ];
      };

      virtualDesktops.number = 9;
      virtualDesktops.rows = 3;
    };

    configFile.breezerc = {
      Common.OutlineCloseButton = true;
      Windeco.ButtonSize = "ButtonSmall";
    };

    configFile.kwinrc = {
      Effect-diminactive.Strength = 15;

      ElectricBorders.BottomLeft = "ActivityManager";

      MouseBindings = {
        CommandAllWheel = "Change Opacity";
        CommandTitlebarWheel = "Change Opacity";
      };
      Windows = {
        MaximizeButtonMiddleClickCommand = "Maximize (horizontal only)";
        MaximizeButtonRightClickCommand = "Maximize (vertical only)";
      };

      Plugins = {
        translucencyEnabled = true;

        # POWER
        sheetEnabled = true; # false
      };

      Wayland.VirtualKeyboardEnabled = true;
    };
  };
}
