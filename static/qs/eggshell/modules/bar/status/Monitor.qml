import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower
import Quickshell.Services.Pipewire
import qs.modules.common
import qs.modules.common.utils
import qs.modules.common.widgets

RowLayout {
  visible: Config.data.audio.enabled
  spacing: Config.data.theme.margins.icon
  property var niriScreenCasts: false

  Process {
    id: niriScreenCastsProcess
    running: true
    command: [ "niri", "msg", "casts" ]
    stdout: StdioCollector {
      onStreamFinished: () => { niriScreenCasts = !(this.text.includes("No screencasts")) }
    }
  }

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: niriScreenCastsProcess.exec({})
  }

  Text {
    text: chooseIcon()
    font.family: tablerIconsFont.name
    font.pixelSize: Config.data.computed.bar.iconSize
    color: chooseColor()
  }

  function chooseIcon() {
    return IconUtils.getIcon("device-desktop")
  }

  function chooseColor() {
    if (niriScreenCasts) {
      return Config.data.monitor.privacyColor
    }
    return Config.data.theme.colors.brightness
  }
}
