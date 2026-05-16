import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.modules.common
import qs.modules.common.widgets

BarSection {
  Image {
    visible: Config.data.windowTitle.icon.enabled
    id: eggshellBarWindowTitleIcon
    source: niri.focusedWindow?.iconPath ?? ""
    sourceSize.width: Config.data.computed.bar.iconSize
    sourceSize.height: Config.data.computed.bar.iconSize
  }

  Text {
    visible: Config.data.windowTitle.title.enabled

    Layout.topMargin: 2

    text: {
      var textRaw = niri.focusedWindow?.title ?? "Desktop"
      var maxLength = Config.data.windowTitle.title.maxLength
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
