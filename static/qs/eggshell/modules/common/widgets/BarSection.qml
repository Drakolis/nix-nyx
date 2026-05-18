import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import qs.modules.common
import qs.modules.common.utils

Rectangle {
  color: ColorUtils.transparentize(Config.data.theme.colors.panel, 0.2)
  height: Config.data.computed.bar.segmentHeight
  radius: Config.data.computed.bar.segmentRadius

  // border.color: Config.data.theme.colors.border
  // border.width: 1

  default property alias content: row.data
  property alias spacing: row.spacing

  RowLayout {
    id: row
    anchors {
      centerIn: parent
    }
    spacing: Config.data.theme.margins.icon
  }

  layer.enabled: true
  layer.effect: MultiEffect {
    shadowEnabled: true
    autoPaddingEnabled: true
    // The vertical offset makes the shadow slightly more prominent
    shadowBlur: 0.5
    shadowScale: 1.01
    shadowOpacity: 1
    shadowColor: Config.data.theme.colors.canvas
  }

  implicitWidth: row.implicitWidth + Config.data.theme.margins.inner * 3
}
