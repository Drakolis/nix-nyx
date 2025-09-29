{ config, ... }:
let
  cfg = config.drakolis.deviceSettings;
in
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

        blur.enable = cfg.formFactor == "desktop";
        desktopSwitching.animation = if (cfg.formFactor == "desktop") then "slide" else "off";
        minimization.animation = if (cfg.formFactor == "desktop") then "squash" else "off";
        windowOpenClose.animation = if (cfg.formFactor == "desktop") then "glide" else "off";
        wobblyWindows.enable = false;
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

        sheetEnabled = true;
      };

      Wayland.VirtualKeyboardEnabled = true;
    };
  };
}
