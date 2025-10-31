let
  style = import ../../../../constants/style.nix;
  notificaionWidth = 500;
in
{
  services.batsignal.enable = true;

  services.swaync = {
    enable = true;
    settings = {
      # Application
      positionX = "center";
      positionY = "top";
      layer = "overlay";
      layer-shell = true;
      cssPriority = "user";
      image-visibility = "when-available";

      # Notifications
      transition-time = 200;
      notification-window-width = notificaionWidth;
      notification-2fa-action = true;
      timeout = 10;
      timeout-low = 5;
      timeout-critical = 0;

      # Control Center
      control-center-margin-top = style.gaps.outer;
      control-center-margin-bottom = style.gaps.outer;
      control-center-margin-right = 0;
      control-center-margin-left = 0;
      control-center-layer = "top";
      control-center-exclusive-zone = true;
      keyboard-shortcuts = true;
      hide-on-clear = true;
      hide-on-action = false;
      fit-to-screen = false;
      relative-timestamps = true;
      # Must be notification width + paddings
      control-center-width = notificaionWidth + style.gaps.outer * 2;
      widgets = [
        "title"
        "dnd"
        "inhibitors"
        "buttons-grid"
        "mpris"
        "notifications"
      ];
      widget-config = {
        title = {
          text = "Notifications";
          clear-all-button = true;
          button-text = "Clear All";
        };
        dnd = {
          text = "Do Not Disturb";
        };
        inhibitors = {
          text = "Inhibitors";
          clear-all-button = true;
          button-text = "Clear All";
        };
        mpris = {
          image-size = 64;
          image-radius = 32;
          blur = false;
        };

        buttons-grid = {
          actions = [
            {
              label = "󰤨";
              type = "toggle";
              active = true;
              command = "sh -c '[[ $SWAYNC_TOGGLE_STATE == true ]] && nmcli radio wifi on || nmcli radio wifi off'";
              update_command = "sh -c '[[ $(nmcli radio wifi) == \"enabled\" ]] && echo true || echo false'";
            }
            {
              label = "󰂯";
              type = "toggle";
              active = true;
              command = "sh -c '[[ $SWAYNC_TOGGLE_STATE == true ]] && bluetoothctl power on || bluetoothctl power off'";
              update_command = "sh -c '[[ bluetoothctl show | grep -q 'Powered: yes' ]] && echo true || echo false'";
            }
          ];
        };
      };

      # Scripts to trigger on notification
      script-fail-notify = true;
    };

    style = ''
      * {
        all: unset;
        font-size: ${toString style.fontSizeLarger}px;
        font-family: ${style.fontGuiNerd};
        transition: 200ms;
      }

      .floating-notifications {
        margin: 5px;
        margin-top: 25px;
      }

      .floating-notifications.background .notification-row .notification-background {
        margin: ${toString style.gaps.inner}px;
        border-radius: ${toString style.border.inner.radius}px;
        box-shadow: 0 0 3px 2px #${style.colors.shadow}, inset 0 0 0 ${toString style.border.inner.width}px #${style.colors.primary};
        background-color: #${style.colors.panel};
        background-color: alpha(#${style.colors.panel}, ${toString style.opacity.background.decimal});
        padding: 0;
      }

      .floating-notifications.background .notification-row .notification-background .notification {
        border-radius: ${toString style.border.inner.radius}px;
        padding: ${toString style.padding.notifications}px;
      }

      .floating-notifications.background .notification-row .notification-background .notification.critical {
        box-shadow: inset 0 0 0 ${toString style.border.inner.width}px #${style.colors.error};
      }

      .floating-notifications.background .notification-row .notification-background .notification.critical .summary {
      }

      .floating-notifications.background .notification-row .notification-background .notification .notification-content {
      }

      .floating-notifications.background .notification-row .notification-background .notification .notification-content .image {
        margin-right: ${toString style.padding.notifications}px;
      }

      .floating-notifications.background .notification-row .notification-background .notification .notification-content .summary {
        font-size: larger;
        font-weight: bolder;
      }

      .floating-notifications.background .notification-row .notification-background .notification .notification-content .time {
        font-size: smaller;
      }

      .floating-notifications.background .notification-row .notification-background .notification .notification-content .body {
        margin-top: ${toString style.gaps.inner}px;
      }

      .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * {
        min-height: 2.6em;
      }

      .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action {
        border-radius: ${toString style.border.inner.radius}px;
        background-color: #${style.colors.activeSurface};
        box-shadow: inset 0 0 0 ${toString style.border.inner.width}px #${style.colors.activeSurface};
        margin-top: ${toString style.gaps.inner}px;
        transition: box-shadow 500ms;
        transition: color 500ms;
        transition: background-color 500ms;
        padding: ${toString style.padding.button}px;
        margin-left: ${toString style.gaps.inner}px;
      }

      .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action:hover {
        box-shadow: inset 0 0 0 ${toString style.border.inner.width}px #${style.colors.primary};
        background-color: #${style.colors.activeSurface};
      }

      .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action:active {
        box-shadow: inset 0 0 0 ${toString style.border.inner.width}px #${style.colors.primary};
        background-color: #${style.colors.primary};
        color: #${style.colors.textInverted};
      }

      .floating-notifications.background .notification-row .notification-background .close-button {
        margin: ${toString style.gaps.inner}px;
        padding: 2px;
        border-radius: 10px;
        color: #${style.colors.textInverted};
        background-color: #${style.colors.error};
      }

      .floating-notifications.background .notification-row .notification-background .close-button:hover {
      }

      .floating-notifications.background .notification-row .notification-background .close-button:active {
      }

      .notification.critical progress {
        background-color: @critical;
      }

      .notification.low progress,
      .notification.normal progress {
        background-color: @accent;
      }

      .control-center {
        margin: 5px;
        margin-top: 25px;
        border-radius: ${toString style.border.outer.radius}px;
        box-shadow: 0 0 3px 2px #${style.colors.shadow}, inset 0 0 0 ${toString style.border.outer.width}px #${style.colors.primary};
        background-color: #${style.colors.background};
        padding: ${toString style.padding.notifications}px;
        padding-top: 0;
      }

      .widget-title,
      .widget-inhibitors,
      .widget-dnd  {
        margin: ${toString style.gaps.inner}px 0;
      }

      .widget-title > label {
        font-size: x-large;
        font-weight: bolder;
      }

      .widget-inhibitors > label,
      .widget-dnd > label  {
        font-size: larger;
        font-weight: bolder;
      }

      .widget-title button,
      .widget-inhibitors button,
      .widget-buttons-grid > flowbox > flowboxchild > button {
        border-radius: ${toString style.border.inner.radius}px;
        background-color: #${style.colors.activeSurface};
        border: ${toString style.border.inner.width}px solid #${style.colors.activeSurface};
        transition: color 500ms;
        transition: background-color 500ms;
        transition: border-color 500ms;
        padding: ${toString style.padding.button}px;
      }

      .widget-title button:hover,
      .widget-inhibitors button:hover {
        border: ${toString style.border.inner.width}px solid #${style.colors.primary};
      }

      .widget-title button:active,
      .widget-inhibitors button:active {
        background-color: #${style.colors.primary};
        border: ${toString style.border.inner.width}px solid #${style.colors.primary};
        color: #${style.colors.textInverted};
      }

      .widget-buttons-grid > flowbox > flowboxchild > button:hover {
        border: ${toString style.border.inner.width}px solid #${style.colors.secondary};
      }

      .widget-buttons-grid > flowbox > flowboxchild > button.toggle:checked {
        background-color: #${style.colors.secondary};
        border: ${toString style.border.inner.width}px solid #${style.colors.activeSurface};
        color: #${style.colors.textInverted};
      }

      .widget-dnd > switch {
        font-size: initial;
        border-radius: ${toString style.border.inner.radius}px;
        background: #313244;
        border: ${toString style.border.inner.width}px solid #${style.colors.activeSurface};
        box-shadow: none;
      }

      .widget-dnd > switch:checked {
        background-color: #${style.colors.primary};
      }

      .widget-dnd > switch slider {
        background-color: #${style.colors.activeSurface};
        border-radius: ${toString style.border.inner.radius}px;
        border: ${toString style.border.inner.width}px solid #${style.colors.activeOutline};
      }

      .widget-mpris {
        margin-top: ${toString style.gaps.inner}px;
        background-color: #${style.colors.panel};
        opacity: ${toString style.opacity.background.decimal};
        box-shadow: 0 0 3px 2px #${style.colors.shadow}, inset 0 0 0 ${toString style.border.inner.width}px #${style.colors.tableLine};
        border-radius: ${toString style.border.inner.radius}px;
      }

      .widget-mpris .widget-mpris-player {
        padding: ${toString style.padding.window}px;
      }

      .widget-mpris .widget-mpris-player .widget-mpris-album-art {
        margin-right: ${toString style.padding.window}px;
      }

      .widget-mpris .widget-mpris-player .widget-mpris-title {
        font-size: larger;
        font-weight: bolder;
      }

      .widget-mpris .widget-mpris-player .widget-mpris-subtitle {
      }

      .widget-mpris .widget-mpris-player .widget-mpris-buttons {
      }

      .widget-mpris .widget-mpris-player > box > button {
        margin: 0 10px;
        border-radius: 30px;
        padding: ${toString style.padding.button}px;
      }

      .widget-mpris .widget-mpris-player > box > button:hover {
        background-color: #${style.colors.activeSurface};
      }

      .widget-mpris .widget-mpris-player > box > button:active {
        background-color: #${style.colors.activeOutline};
      }

      .control-center .notification-row .notification-background {
        margin: ${toString style.gaps.inner}px 0;
        border-radius: ${toString style.border.inner.radius}px;
        box-shadow: 0 0 3px 2px #${style.colors.shadow}, inset 0 0 0 ${toString style.border.inner.width}px #${style.colors.tableLine};
        background-color: alpha(#${style.colors.panel}, ${toString style.opacity.background.decimal});
        padding: 0;
      }

      .control-center .notification-row .notification-background .notification {
        padding: ${toString style.padding.notifications}px;
        border-radius: ${toString style.border.inner.radius}px;
      }

      .control-center .notification-row .notification-background .notification.critical {
        box-shadow: inset 0 0 0 ${toString style.border.inner.width}px #${style.colors.error};
      }

      .control-center .notification-row .notification-background .notification.critical .summary {
      }

      .control-center .notification-row .notification-background .notification .notification-content {
      }

      .control-center .notification-row .notification-background .notification .notification-content .image {
        margin-right: ${toString style.padding.window}px;
      }

      .control-center .notification-row .notification-background .notification .notification-content .summary {
        font-size: larger;
        font-weight: bolder;
      }

      .control-center .notification-row .notification-background .notification .notification-content .time {
        font-size: smaller;
      }

      .control-center .notification-row .notification-background .notification .notification-content .body {
        margin-top: ${toString style.gaps.inner}px;
      }

      .control-center .notification-row .notification-background .notification > *:last-child > * {
        min-height: 2.6em;
      }

      .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action {
        border-radius: ${toString style.border.inner.radius}px;
        background-color: #${style.colors.activeSurface};
        box-shadow: inset 0 0 0 ${toString style.border.inner.width}px #${style.colors.activeSurface};
        margin-top: ${toString style.gaps.inner}px;
        transition: box-shadow 500ms;
        transition: color 500ms;
        transition: background-color 500ms;
        padding: ${toString style.padding.button}px;
      }

      .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action:hover {
        box-shadow: inset 0 0 0 ${toString style.border.inner.width}px #${style.colors.primary};
        background-color: #${style.colors.activeSurface};
      }

      .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action:active {
        box-shadow: inset 0 0 0 ${toString style.border.inner.width}px #${style.colors.primary};
        background-color: #${style.colors.primary};
        color: #${style.colors.textInverted};
        margin-left: ${toString style.gaps.inner}px;
      }

      .control-center .notification-row .notification-background .close-button {
        margin: ${toString style.gaps.inner}px;
        padding: 2px;
        border-radius: 10px;
        color: #${style.colors.textInverted};
        background-color: #${style.colors.error};
      }

      .control-center .notification-row .notification-background .close-button:hover {
      }

      .control-center .notification-row .notification-background .close-button:active {
      }

      .control-center .notification-row .notification-background:hover {
        box-shadow: 0 0 3px 2px #${style.colors.shadow}, inset 0 0 0 ${
          toString (style.border.inner.width + 1)
        }px #${style.colors.primary};
      }

      .control-center .notification-row .notification-background:active {
        box-shadow: 0 0 3px 2px #${style.colors.shadow}, inset 0 0 0 ${
          toString (style.border.inner.width + 1)
        }px #${style.colors.primary};
      }

      .widget-buttons-grid {
        margin: ${toString style.gaps.inner}px 0;
      }

      .widget-buttons-grid > flowbox > flowboxchild > button {
        color: #${style.colors.textGray};
        font-size: 2rem;
        margin-right: ${toString style.gaps.inner}px;
      }

      .widget-buttons-grid > flowbox > flowboxchild > button label {
        font-size: 1.5rem;
      }
    '';
  };

}
