{
  programs.plasma = {
    kscreenlocker = {
      appearance = {
        alwaysShowClock = true;
        showMediaControls = true;
      };

      autoLock = true;
      timeout = 10; # min, POWER

      lockOnResume = true;

      passwordRequired = true;
      passwordRequiredDelay = 5;
    };

    powerdevil = {
      general.pausePlayersOnSuspend = true;

      AC = {
        powerProfile = "performance";

        autoSuspend = {
          action = "sleep";
          idleTimeout = 3600; # sec, POWER
        };
        dimDisplay = {
          enable = true;
          idleTimeout = 300; # sec, POWER
        };
        turnOffDisplay = {
          idleTimeout = 900; # sec, POWER
          idleTimeoutWhenLocked = 300; # sec, POWER
        };
        powerButtonAction = "showLogoutScreen";

        displayBrightness = 100;

        inhibitLidActionWhenExternalMonitorConnected = true;
        whenLaptopLidClosed = "lockScreen";
      };

      battery = {
        powerProfile = "balanced";

        autoSuspend = {
          action = "sleep";
          idleTimeout = 600; # sec, POWER
        };
        dimDisplay = {
          enable = true;
          idleTimeout = 120; # sec, POWER
        };
        turnOffDisplay = {
          idleTimeout = 300; # sec, POWER
          idleTimeoutWhenLocked = 120; # sec, POWER
        };
        powerButtonAction = "sleep";

        displayBrightness = 80;

        inhibitLidActionWhenExternalMonitorConnected = true;
        whenLaptopLidClosed = "lockScreen";
      };

      lowBattery = {
        powerProfile = "powerSaving";

        autoSuspend = {
          action = "sleep";
          idleTimeout = 300; # sec, POWER
        };
        dimDisplay = {
          enable = true;
          idleTimeout = 30; # sec, POWER
        };
        turnOffDisplay = {
          idleTimeout = 120; # sec, POWER
          idleTimeoutWhenLocked = 60; # sec, POWER
        };
        powerButtonAction = "sleep";

        displayBrightness = 60;

        inhibitLidActionWhenExternalMonitorConnected = false;
        whenLaptopLidClosed = "sleep";
      };

      batteryLevels.lowLevel = 30;

      batteryLevels.criticalLevel = 5;
      batteryLevels.criticalAction = "hibernate";
    };
  };
}
