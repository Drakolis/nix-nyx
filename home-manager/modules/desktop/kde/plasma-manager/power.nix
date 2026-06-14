{ config, lib, ... }:
let
  formFactor = config.drakolis.deviceSettings.formFactor;
  isSleepy = formFactor == "laptop" || formFactor == "tablet";
  neverSleeps = formFactor == "server";

  lightsTimeout = if isSleepy then 150 else 150;
  lockTimeout = if isSleepy then 300 else 600;
  monitorTimeout = if isSleepy then 330 else 630;
  sleepTimeout = if isSleepy then 1800 else 3600;
in
{
  programs.plasma = {
    kscreenlocker = {
      appearance = {
        alwaysShowClock = true;
        showMediaControls = true;
      };

      autoLock = true;
      timeout = lockTimeout / 60; # min, POWER

      lockOnResume = true;

      passwordRequired = true;
      passwordRequiredDelay = 5;
    };

    powerdevil = {
      general.pausePlayersOnSuspend = true;

      AC = {
        powerProfile = "balanced";

        autoSuspend = {
          action = if neverSleeps then "nothing" else "sleep";
          idleTimeout = sleepTimeout; # sec, POWER
        };
        dimDisplay = {
          enable = true;
          idleTimeout = lightsTimeout; # sec, POWER
        };
        turnOffDisplay = {
          idleTimeout = monitorTimeout; # sec, POWER
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
          idleTimeout = sleepTimeout; # sec, POWER
        };
        dimDisplay = {
          enable = true;
          idleTimeout = lightsTimeout; # sec, POWER
        };
        turnOffDisplay = {
          idleTimeout = monitorTimeout; # sec, POWER
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
          idleTimeout = sleepTimeout; # sec, POWER
        };
        dimDisplay = {
          enable = true;
          idleTimeout = lightsTimeout; # sec, POWER
        };
        turnOffDisplay = {
          idleTimeout = monitorTimeout; # sec, POWER
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
