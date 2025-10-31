{ pkgs, ... }:
let
  style = import ../../../../constants/style.nix;
in
{
  home.packages = with pkgs; [
    bluetui
    (writeShellScriptBin "wttr-waybar" ''
      DATA=$(curl -s "wttr.in/?format=j1")

      # Extract values
      TEMP=$(echo "$DATA" | jq -r '.current_condition[0].temp_C')
      WEATHER_CODE=$(echo "$DATA" | jq -r '.current_condition[0].weatherCode')
      WEATHER_DESCRIPTION=$(echo "$DATA" | jq -r '.current_condition[0].weatherDesc[0].value')

      # Map Weather Codes to NerdFonts Icons
      declare -A WEATHER_ICONS
      WEATHER_ICONS=(
          ["113"]=""  # Clear/Sunny
          ["116"]=""  # Partly Cloudy
          ["119"]=""  # Cloudy
          ["122"]=""  # Overcast
          ["143"]=""  # Mist
          ["176"]=""  # Patchy Rain Showers
          ["179"]=""  # Patchy Snow Showers
          ["182"]=""  # Patchy Sleet
          ["185"]=""  # Patchy Freezing Drizzle
          ["200"]=""  # Thundery Showers
          ["227"]=""  # Blowing Snow
          ["230"]="❄️"  # Blizzard
          ["248"]=""  # Fog
          ["260"]=""  # Freezing Fog
          ["263"]=""  # Light Drizzle
          ["266"]=""  # Drizzle
          ["281"]=""  # Freezing Drizzle
          ["284"]=""  # Heavy Freezing Drizzle
          ["293"]=""  # Light Rain
          ["296"]=""  # Rain
          ["299"]=""  # Moderate Rain
          ["302"]=""  # Heavy Rain
          ["305"]=""  # Torrential Rain
          ["308"]=""  # Extreme Rain
          ["311"]=""  # Light Freezing Rain
          ["314"]=""  # Freezing Rain
          ["317"]=""  # Light Sleet
          ["320"]=""  # Sleet
          ["323"]=""  # Light Snow
          ["326"]=""  # Patchy Light Snow
          ["329"]=""  # Moderate Snow
          ["332"]=""  # Heavy Snow
          ["335"]="❄️"  # Blizzard
          ["338"]="❄️"  # Heavy Blizzard
          ["350"]=""  # Ice Pellets
          ["353"]=""  # Light Rain Showers
          ["356"]=""  # Rain Showers
          ["359"]=""  # Heavy Rain Showers
          ["362"]=""  # Light Sleet Showers
          ["365"]=""  # Sleet Showers
          ["368"]=""  # Light Snow Showers
          ["371"]="❄️"  # Heavy Snow Showers
          ["374"]=""  # Light Ice Pellet Showers
          ["377"]=""  # Ice Pellet Showers
          ["386"]=""  # Thundery Showers
          ["389"]=""  # Thunderstorms
          ["392"]=""  # Thundery Snow Showers
          ["395"]="❄️"  # Snowstorm
      )

      ICON=''${WEATHER_ICONS[$WEATHER_CODE]:-""}

      # Output JSON for Waybar
      echo "{\"text\": \"$ICON  $TEMP°C\", \"tooltip\": \"$WEATHER_DESCRIPTION\"}"
    '')
  ];

  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
          "niri/workspaces"
          "niri/window"
        ];
        modules-center = [
          "custom/notification"
          "clock"
          "custom/weather"
          "gamemode"
        ];
        modules-right = [
          "hyprland/language"
          "niri/language"
          "pulseaudio"
          "backlight"
          "battery"
          "bluetooth"
          "network"
          "tray"
        ];
        "niri/workspaces" = {
          active-only = false;
          all-outputs = true;
          format = " {icon} ";
          format-icons = {
            default = "";
            empty = "";
            special = "";
          };
          show-special = true;
          sort-by = "number";
        };
        "hyprland/workspaces" = {
          active-only = false;
          all-outputs = true;
          format = " {icon} ";
          format-icons = {
            default = "";
            empty = "";
            special = "";
          };
          show-special = true;
          sort-by = "number";
        };
        "niri/window" = {
          separate-outputs = true;
          rewrite = {
            "(.*) — LibreWolf" = "󰈹 $1";
            "LibreWolf" = "󰈹";
            "(.*) — Mozilla Firefox" = "󰈹 $1";
            "Mozilla Firefox" = "󰈹";
            "(.*) - Visual Studio Code" = "󰨞 $1";
            "Visual Studio Code" = "󰨞";
            "(.*) - VSCodium" = " $1";
            "VSCodium" = "";
            "Telegram .*" = "";
            "Element (.*)" = "󰬌 $1";
          };
        };
        "hyprland/window" = {
          separate-outputs = true;
          rewrite = {
            "(.*) — LibreWolf" = "󰈹 $1";
            "LibreWolf" = "󰈹";
            "(.*) — Mozilla Firefox" = "󰈹 $1";
            "Mozilla Firefox" = "󰈹";
            "(.*) - Visual Studio Code" = "󰨞 $1";
            "Visual Studio Code" = "󰨞";
            "(.*) - VSCodium" = " $1";
            "VSCodium" = "";
            "Telegram .*" = "";
            "Element (.*)" = "󰬌 $1";
          };
        };
        "niri/language" = {
          format-en = "󰘵 ENG";
          format-ru = "󰘵 RUS";
        };
        "hyprland/language" = {
          format-en = "󰘵 ENG";
          format-ru = "󰘵 RUS";
        };
        "custom/notification" = {
          format = "{icon}";
          format-icons = {
            notification = "<span foreground='#${style.colors.error}'>󰂚</span>";
            none = "󰂚";
            dnd-notification = "<span foreground='#${style.colors.error}'>󰂛/span>";
            dnd-none = "󰂛";
            inhibited-notification = "<span foreground='#${style.colors.error}'>󰂚</span>";
            inhibited-none = "󰂚";
            dnd-inhibited-notification = "<span foreground='#${style.colors.error}'>󰂛</span>";
            dnd-inhibited-none = "󰂛";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };
        pulseaudio = {
          scroll-step = 5;
          format = "{icon} {volume}%   {format_source}";
          format-source = "󰍬 {volume}%";
          format-source-muted = "󰍭  OFF";
          format-muted = "󰝟 OFF   {format_source}";
          format-icons = {
            default = [
              "󰕿 "
              "󰖀 "
              "󰕾"
            ];
          };
          on-click = "pavucontrol-qt";
          on-click-right = "qpwgraph";
        };
        backlight = {
          scroll-step = 5;
          device = "intel_backlight";
          format = "{icon} {percent}%";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];
        };
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };
        bluetooth = {
          format = "󰂯 UNK";
          format-off = "󰂲 OFF";
          format-on = "󰂯 RDY";
          format-disabled = "󰂲 OFF";
          format-connected = "󰂯 CON";
          format-no-controller = "󰂲 N/A";
          tooltip-format = "{controller_alias} - {status} - {num_connections}";
          tooltip-format-disabled = "{controller_alias} - Disabled";
          tooltip-format-off = "{controller_alias} - Turned Off";
          on-click = "kitty bluetui";
        };
        network = {
          interface = "*s0";
          format = "󱘖 N/A";
          format-wifi = "{icon} {signalStrength}%";
          format-ethernet = "󰌘 ETH";
          format-disconnected = "󰤭 NON";
          tooltip-format-wifi = "{ifname} - {essid} - {ipaddr}";
          tooltip-format-ethernet = "{ifname} - {ipaddr}";
          tooltip-format-disconnected = "{ifname} - Disconnected";
          tooltip-format = "{ifname} - Disconnected";
          format-icons = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
          on-click = "nm-connection-editor";
        };
        clock = {
          interval = 1;
          timezone = "Europe/Berlin";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
          format-alt = "󰃮 {:%d.%m.%Y}";
          format = "󰅐 {:%H:%M:%S}";
          on-right-click = "gsimplecal";
        };
        tray = {
          icon-size = style.fontSizeLarger + 1;
          spacing = style.fontSizeLarger;
        };
        gamemode = {
          format = "{glyph} GAM";
          glyph = "G";
          use-icon = false;
        };
        "custom/lock" = {
          tooltip = false;
          on-click = "loginctl lock-session";
          format = "󰌾";
        };
        "custom/power" = {
          tooltip = false;
          on-click = "wlogout &";
          format = "󰐥";
        };
        "custom/weather" = {
          format = "{}";
          exec = "wttr-waybar";
          return-type = "json";
          interval = 900;
          on-right-click = "kitty --hold wttr";
          exec-on-event = "on-click";
        };
        "custom/music" = {
          format = "󰝚 {}";
          escape = true;
          interval = 5;
          tooltip = false;
          exec = "playerctl metadata --format='{{ artist }} - {{ title }}'";
          on-click = "playerctl play-pause";
          max-length = 50;
        };
      };
    };

    style = ''
      * {
        all: unset;
        font-family: "${style.fontGuiNerd}";
        font-weight: 500;
        font-size: ${toString style.fontSizeLarger}px;
        min-height: 0;
      }

      #waybar {
        background: none;
        color: #${style.colors.text};
        margin: 5px;
      }

      /* Section - Any */
      #workspaces, #window, #tray, #custom-notification,
      #pulseaudio, #wireplumber, #backlight, #battery,
      #bluetooth, #network, #language, #custom-lock,
      #clock, #custom-power, #custom-music, #custom-weather {
        background-color: #${style.colors.waybar};
        padding: 0.6rem 0.5rem 0.5rem;
        margin-top: 5px;
      }

      /* Section - Single */
      #workspaces, #window, #tray {
        border-radius: 2rem;
        margin-left: 5px;
        margin-right: 5px;
      }

      /* Section - Left */
      #language, #custom-lock, #custom-notification {
        border-radius: 2rem 0 0 2rem;
        padding-right: 0.5rem;
        margin-left: 5px;
      }

      /* Section - Middle */
      #pulseaudio, #wireplumber, #backlight, #battery,
      #bluetooth, #clock {
        padding-left: 0.5rem;
        padding-right: 0.5rem;
      }

      /* Section - Right */
      #custom-power, #custom-music, #network, #custom-weather {
        border-radius: 0 2rem 2rem 0;
        padding-left: 0.5rem;
        margin-right: 5px;
      }

      /* Section - Primary Color */
      #workspaces, #window, #tray {
        color: #${style.colors.primary};
      }

      /* Section - Weather */
      #custom-weather {
        color: #${style.colors.weather};
      }

      /* Section - Workspaces */
      #workspaces {
        margin-left: 10px;
        padding: 0 0 0 0;
      }

      #workspaces button {
        border-radius: 2rem;
        padding: 0.6rem 0.5rem 0.5rem 0.5rem;
      }

      #workspaces button.active {
        background-color: #${style.colors.activeSurface};
      }

      #workspaces button.urgent {
        color: #${style.colors.error};
      }

      /* Section - Window */
      window#waybar.empty #window {
        margin-left: 5px;
        background-color: transparent;
      }

      /* Section - Notifications */
      #custom-notification {
        padding-left: 0.7rem;
        padding-right: 0.5rem;
      }

      /* Section - Lock Screen */
      #custom-lock {
        color: #${style.colors.locked};
        padding-left: 0.8rem;
        padding-right: 0.5rem;
      }

      /* Section - Shutdown */
      #custom-power {
        color: #${style.colors.error};
        padding-left: 0.5rem;
        padding-right: 0.7rem;
        margin-right: 10px;
      }

      /* Section - Keyboard */
      #language {
        color: #${style.colors.keyboard};
      }

      /* Section - Sound */
      #pulseaudio, #wireplumber {
        color: #${style.colors.sound};
      }

      /* Section - Brightness */
      #backlight {
        color: #${style.colors.brightness};
      }

      /* Section - Battery */
      #battery {
        color: #${style.colors.success};
      }

      /* Section - Battery Charging */
      #battery.charging {
        color: #${style.colors.info};
      }

      /* Section - Battery Low */
      #battery.warning:not(.charging) {
        /* Had to use this color, since warning===brightness */
        color: #${style.colors.locked};
      }

      /* Section - Battery Critical */
      #battery.critical:not(.charging) {
        color: #${style.colors.error};
      }

      /* Section - Bluetooth */
      #bluetooth {
        color: #${style.colors.bluetooth};
      }

      /* Section - Network */
      #network {
        color: #${style.colors.network};
      }

      /* Section - Clock */
      #clock {
        color: #${style.colors.clock};
      }

      /* Section - Hovering */
      #workspaces button:hover, #pulseaudio:hover, #backlight:hover,
      #battery:hover, #bluetooth:hover, #network:hover, #clock:hover,
      #custom-power:hover, #custom-notification:hover, #language:hover,
      #custom-lock:hover, #wireplumber:hover {
        background-color: #${style.colors.activeSurface};
      }

      /* Popups */
      tooltip {
        padding: 5px;
      }

      #tray menu, tooltip label {
        padding: 5px;
        border-radius: 7px;
        background-color: #${style.colors.background};
        box-shadow: 0 0 3px 2px #${style.colors.shadow};
        color: #${style.colors.text}
      }

      menu {
        color: #${style.colors.text};
        font-weight: normal;
        background-color: #${style.colors.background};
        border-radius: 7px;
        box-shadow: 0 0 3px 2px #${style.colors.shadow};
        border: solid 1px #${style.colors.activeSurface};
        padding: 5px;
      }

      menu menuitem:disabled {
        color: #${style.colors.textGray};
      }

      menu menuitem {
        color: #${style.colors.text};
        border: solid 1px transparent;
        border-radius: 7px;
        padding: 5px;
      }

      menu menuitem arrow {
      }

      menu separator {
        background-color: #${style.colors.activeSurface};
        margin: 0 5px;
      }

      menu menuitem:hover {
        background-color: #4f4465;
        border: solid 1px #${style.colors.primary};
      }

      #tray {
        padding-top: 0.35rem;
      }
    '';
  };
}
