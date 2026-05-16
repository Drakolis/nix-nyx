import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import qs.modules.common
import qs.modules.common.utils

Rectangle {
  width: Config.data.computed.bar.iconSize
  height: Config.data.computed.bar.iconSize
  color: "transparent"
  property var applicationId: ""
  property var icon: ""

  Text {
    id: iconText
    text: replaceIcon()
    color: replaceColor()
    font.family: tablerIconsFont.name
    font.pixelSize: Config.data.computed.bar.iconSize
  }

  readonly property var trayIconsColors: ({
      "caffeine-cup-empty": {
        icon: "cup-off",
        color: Config.data.theme.colors.textDisabled
      },
      "caffeine-cup-full": {
        icon: "cup",
        color: Config.data.theme.colors.secondary
      },
      "gammastep-status-off": {
        icon: "bulb-off",
        color: Config.data.theme.colors.textDisabled
      },
      "gammastep-status-on": {
        icon: "bulb",
        color: Config.data.theme.colors.maroon
      },
      "drive-removable-media-usb-panel": {
        icon: "usb",
        color: Config.data.theme.colors.text
      },
      "org.telegram.desktop-symbolic": {
        icon: "brand-telegram",
        color: Config.data.theme.colors.blue
      },
      "org.telegram.desktop-mute-symbolic": {
        icon: "brand-telegram",
        color: Config.data.theme.colors.blue
      },
      "org.telegram.desktop-attention-symbolic": {
        icon: "brand-telegram",
        color: Config.data.theme.colors.warning
      },

      "telegram": { icon: "brand-telegram", color: "#0088CC" },

      "firefox": { icon: "firefox", color: "#FF7139" },

      "firefox": { icon: "firefox", color: "#FF7139" },
      "discord": { icon: "brand-discord", color: "#5865F2" },
      "spotify": { icon: "brand-spotify", color: "#1DB954" },
      "slack": { icon: "brand-slack", color: "#4A154B" },
      "code": { icon: "brand-visual-studio-code", color: "#007ACC" },
      "thunderbird": { icon: "thunderbird", color: "#0078D4" },
      "chromium": { icon: "chromium", color: "#4285F4" },
      "microsoft-edge": { icon: "microsoft-edge", color: "#0078D7" },
      "spotify": { icon: "brand-spotify", color: "#1DB954" },
  })

  function replaceIcon() {
    console.log(applicationId, icon)
    if (applicationId === "systray") {
      return IconUtils.getIcon("home-link")
    }
    if (applicationId === "Slack_status_icon_1") {
      return IconUtils.getIcon("brand-slack")
    }
    if (applicationId === "Syncthing Tray") {
      return IconUtils.getIcon("cloud-cog")
    }
    let iconFilename = icon.split("/").slice(-1)[0]
    console.log(iconFilename)
    return IconUtils.getIcon(trayIconsColors[iconFilename] ? trayIconsColors[iconFilename].icon : "question-mark")
  }

  function replaceColor() {
    if (applicationId === "Syncthing Tray") {
      return Config.data.theme.colors.success
    }
    let iconFilename = icon.split("/").slice(-1)[0]
    return trayIconsColors[iconFilename] ? trayIconsColors[iconFilename].color : Config.data.theme.colors.text
  }
}
