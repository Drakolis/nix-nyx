import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Networking
import qs.modules.common
import qs.modules.common.utils
import qs.modules.common.widgets

RowLayout {
  visible: Config.data.network.enabled
  spacing: Config.data.theme.margins.icon

  property var wifiDevices: (Networking.devices.values.filter(d => d.type === DeviceType.Wifi))
  property var wiredDevices: (Networking.devices.values.filter(d => d.type === DeviceType.Wired))
  property var wifiDevicesWithNetwork: (
    wifiDevices.map(
      d => {
        const connectedNetwork = d.networks.values.find(n => n.connected)
        return {
          name: d.name,
          connected: d.connected,
          networkName: connectedNetwork ? connectedNetwork.name : "",
          networkSignal: connectedNetwork ? connectedNetwork.signalStrength : 0,
        }
      }
    )
  )
  property var bestWifiConnectedDevice: (
    wifiDevicesWithNetwork.sort((a, b) => a.networkSignal - b.networkSignal)[0]
  )

  Text {
    id: icon
    text: chooseIcon()
    font.family: tablerIconsFont.name
    font.pixelSize: Config.data.computed.bar.iconSize
    color: chooseColor()
  }

  Text {
    visible: Config.data.network.showPercentage && bestWifiConnectedDevice.networkSignal

    Layout.topMargin: 2

    font: Config.data.theme.fontBar
    text: Number(bestWifiConnectedDevice.networkSignal * 100).toFixed(0) + "%"

    color: chooseColor()
  }

  function chooseIcon() {
    if (Networking.wifiEnabled && Networking.wifiHardwareEnabled && wifiDevices.length > 0) {
      if (bestWifiConnectedDevice.networkName) {
        if (bestWifiConnectedDevice.networkSignal >= 0.8) {
          return IconUtils.getIcon("wifi")
        }
        if (bestWifiConnectedDevice.networkSignal >= 0.6) {
          return IconUtils.getIcon("wifi-2")
        }
        if (bestWifiConnectedDevice.networkSignal >= 0.4) {
          return IconUtils.getIcon("wifi-1")
        }
        if (bestWifiConnectedDevice.networkSignal <= 0.2) {
          return IconUtils.getIcon("wifi-0")
        }
      }
    } else {
      if (!wiredDevices || wiredDevices.every(d => !d.connected)) {
        return IconUtils.getIcon("wifi-off")
      }
    }

    if (wiredDevices && wiredDevices.some(d => d.connected)) {
      return IconUtils.getIcon("network")
    }

    return IconUtils.getIcon("network-off")
  }

  function chooseColor() {
    const isConnected = Networking.devices.values.some(d => d.connected)
    if (isConnected) {
      return Config.data.theme.colors.network
    }
    return Config.data.theme.colors.textDisabled
  }
}
