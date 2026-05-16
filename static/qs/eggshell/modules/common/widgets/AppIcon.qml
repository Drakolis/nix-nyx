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

  Text {
    text: "\uFF14"
    font.family: tablerIconsFont.name
    font.pixelSize: Config.data.computed.bar.iconSize
    color: Config.data.theme.colors.success
  }
}
