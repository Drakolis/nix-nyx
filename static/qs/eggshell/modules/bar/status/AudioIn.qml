import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import qs.modules.common
import qs.modules.common.utils
import qs.modules.common.widgets

RowLayout {
  visible: Config.data.audio.enabled && Config.data.audio.showMicrophone
  spacing: Config.data.theme.margins.icon

  PwObjectTracker {
    objects: [ Pipewire.defaultAudioSource ]
  }

  PwNodeLinkTracker {
    id: sourceLinkTracker
    node: Pipewire.defaultAudioSource
  }

  Text {
    text: chooseIcon()
    font.family: tablerIconsFont.name
    font.pixelSize: Config.data.computed.bar.iconSize
    color: chooseColor()
  }
  Text {
    visible: Config.data.audio.showMicrophone && Config.data.audio.showMicrophonePercentage

    Layout.topMargin: 2

    font: Config.data.theme.fontBar
    text: Number(Pipewire.defaultAudioSource.audio.volume * 100).toFixed(0) + "%"
    color: chooseColor()
  }

  function chooseIcon() {
    if (Pipewire.defaultAudioSource.audio.muted || Pipewire.defaultAudioSource.audio.volume == 0) {
      return IconUtils.getIcon("microphone-off")
    }
    return IconUtils.getIcon("microphone")
  }

  function chooseColor() {
    if (sourceLinkTracker.linkGroups.length > 0) {
      return Config.data.audio.microphonePrivacyColor
    }
    return Config.data.theme.colors.audio
  }
}
