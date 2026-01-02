from ignis import widgets

from ignis.services.network import NetworkService

network = NetworkService.get_default()

# TODO: Subscribe OSD for new_device/remove_device events

def network_render_contents(ethernet, wifi, vpn):

  show_wifi = wifi.enabled and wifi.is_connected
  ethernet_icon = ethernet.icon_name
  ethernet_label = "ON" if ethernet.is_connected else "OFF"

  wifi_icon = wifi.icon_name
  wifi_connected_devices = [device for device in wifi.devices if device.is_connected]
  wifi_label = f"{wifi_connected_devices[0].ap.strength}%" if (len(wifi_connected_devices)>0) else "ON"
  wifi_label = wifi_label if wifi.enabled else "OFF"

  return [
    widgets.Icon(
      css_classes=["network-label"],
      image=wifi_icon if show_wifi else ethernet_icon,
      pixel_size=16,
    ),
    widgets.Label(
      css_classes=["network-label", "label-bar"],
      label=wifi_label if show_wifi else ethernet_label,
    ),
  ]

def network_status() -> widgets.EventBox:
  on_click_handler = lambda self: True

  network_widgets = network.bind_many(
    ["ethernet", "wifi", "vpn"],
    network_render_contents
  )

  return widgets.EventBox(
    on_right_click=on_click_handler,
    spacing=5,
    child=network_widgets,
  )
