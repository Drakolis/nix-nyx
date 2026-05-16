import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import qs.modules.common
import qs.modules.common.utils
import qs.modules.common.widgets

RowLayout {
  visible: Config.data.audio.enabled
  spacing: Config.data.theme.margins.icon

  PwObjectTracker {
    objects: [ Pipewire.defaultAudioSink ]
  }

  Text {
    text: chooseIcon()
    font.family: tablerIconsFont.name
    font.pixelSize: Config.data.computed.bar.iconSize
    color: chooseColor()
  }
  Text {
    visible: Config.data.audio.showPercentage

    Layout.topMargin: 2

    font: Config.data.theme.fontBar
    text: Number(Pipewire.defaultAudioSink.audio.volume * 100).toFixed(0) + "%"

    color: chooseColor()
  }

  function chooseIcon() {
    if (Pipewire.defaultAudioSink.audio.muted) {
      return IconUtils.getIcon("volume-off")
    }
    if (Pipewire.defaultAudioSink.audio.volume >= 0.65) {
      return IconUtils.getIcon("volume")
    }
    if (Pipewire.defaultAudioSink.audio.volume >= 0.32) {
      return IconUtils.getIcon("volume-2")
    }
    if (Pipewire.defaultAudioSink.audio.volume > 0) {
      return IconUtils.getIcon("volume-4")
    }
    if (Pipewire.defaultAudioSink.audio.volume == 0) {
      return IconUtils.getIcon("volume-3")
    }
    return IconUtils.getIcon("volume-off")
  }

  function chooseColor() {
    return Config.data.theme.colors.audio
  }
}
