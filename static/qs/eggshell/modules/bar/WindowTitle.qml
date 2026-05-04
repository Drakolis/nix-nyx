import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import qs.modules.common
import qs.modules.common.utils

Rectangle {
  visible: niri.focusedWindow !== null
  color: Config.data.theme.colors.panel
  height: Config.data.theme.fontBar.pixelSize * 2
  radius: Config.data.theme.fontBar.pixelSize * 2
  implicitWidth: childrenRect.width + Config.data.theme.fontBar.pixelSize * 1.5

  Row {
    anchors {
      centerIn: parent
    }
    spacing: Config.data.theme.fontBar.pixelSize * 0.325

    Image {
      id: eggshellBarWindowTitleIcon
      anchors {
        verticalCenter: parent.verticalCenter
      }
      source: niri.focusedWindow.iconPath
      sourceSize.width: Config.data.theme.fontBar.pixelSize * 1.5
      sourceSize.height: Config.data.theme.fontBar.pixelSize * 1.5
    }

    Text {
      anchors {
        verticalCenter: parent.verticalCenter
      }
      text: {
        var textRaw = niri.focusedWindow?.title ?? "Desktop"
        var maxLength = 50
        if (textRaw.length > maxLength)
        return textRaw.substring(0, maxLength) + "…"
        return textRaw
      }

      color: Config.data.theme.colors.primary
      font: Config.data.theme.fontBar
      elide: Text.ElideRight
      maximumLineCount: 1
    }
  }

  layer.enabled: true
  layer.effect: MultiEffect {
    shadowEnabled: true
    autoPaddingEnabled: true
    // The vertical offset makes the shadow slightly more prominent
    shadowBlur: 0.5
    shadowColor: Config.data.theme.colors.canvas
  }
}
