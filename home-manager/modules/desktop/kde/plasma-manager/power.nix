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
        powerProfile = "balanced";

        autoSuspend = {
          action = "sleep";
          idleTimeout = 900; # sec, POWER
        };
        dimDisplay = {
          enable = true;
          idleTimeout = 300; # sec, POWER
        };
        turnOffDisplay = {
          idleTimeout = 600; # sec, POWER
          idleTimeoutWhenLocked = 60; # sec, POWER
        };
        powerButtonAction = "showLogoutScreen";

        inhibitLidActionWhenExternalMonitorConnected = true;
        whenLaptopLidClosed = "lockScreen";
      };

      battery = {
        powerProfile = "powerSaving";

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
          idleTimeoutWhenLocked = 60; # sec, POWER
        };
        powerButtonAction = "showLogoutScreen";

        displayBrightness = 80;

        inhibitLidActionWhenExternalMonitorConnected = true;
        whenLaptopLidClosed = "sleep";
      };

      lowBattery = {
        powerProfile = "powerSaving";

        autoSuspend = {
          action = "sleep";
          idleTimeout = 300; # sec, POWER
        };
        dimDisplay = {
          enable = true;
          idleTimeout = 60; # sec, POWER
        };
        turnOffDisplay = {
          idleTimeout = 120; # sec, POWER
          idleTimeoutWhenLocked = 60; # sec, POWER
        };
        powerButtonAction = "showLogoutScreen";

        displayBrightness = 45;

        inhibitLidActionWhenExternalMonitorConnected = false;
        whenLaptopLidClosed = "sleep";
      };

      batteryLevels.lowLevel = 25;

      batteryLevels.criticalLevel = 5;
      batteryLevels.criticalAction = "sleep";
    };
  };
}
