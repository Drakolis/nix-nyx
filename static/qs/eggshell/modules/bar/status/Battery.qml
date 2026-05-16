import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.UPower
import qs.modules.common
import qs.modules.common.utils
import qs.modules.common.widgets

RowLayout {
  visible: Config.data.battery.enabled && (UPower.displayDevice.isLaptopBattery || Config.data.battery.showAlways)
  spacing: Config.data.theme.margins.icon
  Text {
    text: chooseIcon()
    font.family: tablerIconsFont.name
    font.pixelSize: Config.data.computed.bar.iconSize
    color: chooseColor()
  }

  Text {
    visible: Config.data.battery.showPercentage

    Layout.topMargin: 2

    font: Config.data.theme.fontBar
    text: Number(UPower.displayDevice.percentage * 100).toFixed(0) + "%"
    color: chooseColor()
  }

  function iconOrientation() {
    if (Config.data.battery.orientation === "vertical") {
      return "-vertical"
    }
    return ""
  }

  function chooseIcon() {
    if (!UPower.displayDevice.isLaptopBattery) {
      return IconUtils.getIcon(`battery${iconOrientation()}-off`)
    }
    if (UPower.displayDevice.state === UPowerDeviceState.Charging) {
      return IconUtils.getIcon(`battery${iconOrientation()}-charging`)
    }
    if (UPower.displayDevice.percentage <= 0.2) {
      return IconUtils.getIcon(`battery${iconOrientation()}`)
    }
    if (UPower.displayDevice.percentage >= 0.2) {
      return IconUtils.getIcon(`battery${iconOrientation()}-1`)
    }
    if (UPower.displayDevice.percentage >= 0.4) {
      return IconUtils.getIcon(`battery${iconOrientation()}-2`)
    }
    if (UPower.displayDevice.percentage >= 0.6) {
      return IconUtils.getIcon(`battery${iconOrientation()}-3`)
    }
    if (UPower.displayDevice.percentage >= 0.8) {
      return IconUtils.getIcon(`battery${iconOrientation()}-4`)
    }
    return IconUtils.getIcon(`battery${iconOrientation()}-exclamation`)
  }

  function chooseColor() {
    if (!UPower.displayDevice.isLaptopBattery) {
      return Config.data.theme.colors.textDisabled
    }
    if (UPower.displayDevice.state === UPowerDeviceState.Charging) {
      return Config.data.theme.colors.info
    }
    if (UPower.displayDevice.percentage <= Config.data.battery.warning) {
      return Config.data.theme.colors.warning
    }
    if (UPower.displayDevice.percentage <= Config.data.battery.critical) {
      return Config.data.theme.colors.error
    }
    return Config.data.theme.colors.success
  }
}
