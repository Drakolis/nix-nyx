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
  visible: Config.data.camera.enabled
  spacing: Config.data.theme.margins.icon
  property var cameraExists: false
  property var cameraBusy: false

  Process {
    id: pollPrivacyProcess
    running: true
    command: [ "lsof", "/dev/video0" ]
    stdout: StdioCollector {
      onStreamFinished: () => { cameraBusy = Boolean(this.text) }
    }
  }

  Process {
    id: pollDeviceProcess
    running: true
    command: [ "cat", "/dev/video0" ]
    stdout: StdioCollector {
      onStreamFinished: () => { cameraExists = !(this.text.includes("No such file")) }
    }
  }

  Timer {
    interval: Config.data.camera.pollPrivacyInterval
    running: true
    repeat: true
    onTriggered: pollPrivacyProcess.exec({})
  }

  Timer {
    interval: Config.data.camera.pollDeviceInterval
    running: true
    repeat: true
    onTriggered: pollDeviceProcess.exec({})
  }

  Text {
    text: chooseIcon()
    font.family: tablerIconsFont.name
    font.pixelSize: Config.data.computed.bar.iconSize
    color: chooseColor()
  }

  function chooseIcon() {
    if (cameraExists) {
      return IconUtils.getIcon("device-computer-camera")
    }
    return IconUtils.getIcon("device-computer-camera-off")
  }

  function chooseColor() {
    if (cameraBusy) {
      return Config.data.camera.privacyColor
    }
    return Config.data.theme.colors.textDisabled
  }
}
