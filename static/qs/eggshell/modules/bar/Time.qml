import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.modules.common
import qs.modules.common.utils
import qs.modules.common.widgets

BarSection {
  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }

  Text {
    text: IconUtils.getIcon("clock")
    font.family: tablerIconsFont.name
    font.pixelSize: Config.data.computed.bar.iconSize
    color: Config.data.theme.colors.clock
  }

  Text {
    Layout.topMargin: 2

    text: Qt.formatDateTime(clock.date, Config.data.clock.format)

    color: Config.data.theme.colors.clock
    font: Config.data.theme.fontBar
  }
}
