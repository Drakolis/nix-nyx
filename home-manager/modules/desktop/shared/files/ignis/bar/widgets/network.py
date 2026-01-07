from ignis import widgets

from ignis.services.network import NetworkService

# TODO: Subscribe OSD for new_device/remove_device events
DEFAULT_ICON = "network-disconnected-symbolic"
DEFAULT_LABEL = "N/A"


class NetworkStatusWidget(widgets.Button):
  def __init__(self):
    self.network = NetworkService.get_default()
    self.show_wifi = False

    network_status_label = [
      widgets.Icon(
        css_classes=["network-label"],
        image=DEFAULT_ICON,
        pixel_size=24,
        hexpand=True,
      ),
    ]

    super().__init__(
      css_classes=["pill-button"],
      on_right_click=lambda self: True,
      child=widgets.Box(child=network_status_label, spacing=5),
    )

    self.network_status_label = network_status_label
    self.network.ethernet.connect(
      "notify::is-connected", lambda x, _: self.update_ethernet(x)
    )
    self.network.wifi.connect("notify::is-connected", lambda x, _: self.update_wifi(x))
    self.network.wifi.connect("notify::enabled", lambda x, _: self.update_wifi(x))
    self.network.vpn.connect("notify::is-connected", lambda x, _: self.update_vpn(x))
    self.update_ethernet(self.network.ethernet)
    self.update_wifi(self.network.wifi)

  def update_ethernet(self, ethernet):
    ethernet_icon = ethernet.icon_name
    ethernet_label = "ON" if ethernet.is_connected else "OFF"

    if not self.show_wifi:
      self.network_status_label[0].set_image(ethernet_icon)

  def update_wifi(self, wifi):
    if self.show_wifi:
      wifi_icon = (
        wifi.icon_name
        if wifi.enabled
        else "network-wireless-hardware-disabled-symbolic"
      )
      wifi_connected_devices = [
        device for device in wifi.devices if device.is_connected
      ]
      wifi_label_con = (
        f"{wifi_connected_devices[0].ap.strength}%"
        if (len(wifi_connected_devices) > 0 and wifi.is_connected)
        else "ON"
      )
      wifi_label = wifi_label_con if wifi.enabled else "OFF"
      self.network_status_label[0].set_image(wifi_icon)
    self.show_wifi = wifi.enabled
