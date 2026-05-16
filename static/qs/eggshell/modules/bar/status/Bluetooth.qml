import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Bluetooth
import qs.modules.common
import qs.modules.common.utils
import qs.modules.common.widgets

RowLayout {
  visible: Config.data.audio.enabled && Config.data.audio.showMicrophone
  spacing: Config.data.theme.margins.icon

  Text {
    id: icon
    text: chooseIcon()
    font.family: tablerIconsFont.name
    font.pixelSize: Config.data.computed.bar.iconSize
    color: chooseColor()
  }

  function chooseIcon() {
    console.log(Bluetooth.defaultAdapter.state)
    if (Bluetooth.defaultAdapter.enabled) {
      if ([BluetoothAdapterState.Enabling, BluetoothAdapterState.Blocked].includes(Bluetooth.defaultAdapter.state)) {
        return IconUtils.getIcon("bluetooth-x")
      }
      if (Bluetooth.defaultAdapter.devices.values.filter(d => d.connected).length > 0) {
        return IconUtils.getIcon("bluetooth-connected")
      }
      return IconUtils.getIcon("bluetooth")
    }
    return IconUtils.getIcon("bluetooth-off")
  }

  function chooseColor() {
    if (Bluetooth.defaultAdapter.enabled) {
      return Config.data.theme.colors.blue
    }
    if (Bluetooth.defaultAdapter.pairable) {

    }
    return Config.data.theme.colors.textDisabled
  }
}
