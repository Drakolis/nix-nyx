{ config, lib, ...}:
let
  formFactor = config.drakolis.deviceSettings.formFactor;
  isSleepy = formFactor == "laptop" || formFactor == "tablet";
  
  lightsTimeout = if isSleepy then 150 else 150;
  lockTimeout = if isSleepy then 300 else 600;
  monitorTimeout =  if isSleepy then 330 else 630;
  sleepTimeout =  if isSleepy then 1800 else 3600;
in
{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock"; # avoid starting multiple hyprlock instances.
        before_sleep_cmd = "loginctl lock-session"; # lock before suspend.
        after_sleep_cmd = "niri msg action power-on-monitors";
        # after_sleep_cmd = "hyprctl dispatch dpms on"; # to avoid having to press a key twice to turn on the display.
      };

      listener = [
        {
          timeout = lightsTimeout; # 2.5min.
          on-timeout = "brightnessctl -s set 10"; # set monitor backlight to minimum, avoid 0 on OLED monitor.
          on-resume = "brightnessctl -r"; # monitor backlight restore.
        }

        # turn off keyboard backlight, comment out this section if you dont have a keyboard backlight.
        {
          timeout = lightsTimeout; # 2.5min.
          on-timeout = ''brightnessctl -sd "tpacpi::kbd_backlight" set 0''; # turn off keyboard backlight.
          on-resume = ''brightnessctl -rd "tpacpi::kbd_backlight"''; # turn on keyboard backlight.
        }

        {
          timeout = lockTimeout; # 5min
          on-timeout = "loginctl lock-session"; # lock screen when timeout has passed
        }

        {
          timeout = monitorTimeout; # 5.5min
          on-timeout = "niri msg action power-off-monitors";
          on-resume = "niri msg action power-on-monitors";
          # TODO: Please make it support hyprland again
          # on-timeout = "hyprctl dispatch dpms off"; # screen off when timeout has passed
          # on-resume = "hyprctl dispatch dpms on"; # screen on when activity is detected after timeout has fired.
        }

        {
          timeout = sleepTimeout; # 30min
          on-timeout = "systemctl suspend"; # suspend pc
        }
      ];
    };
  };
}
