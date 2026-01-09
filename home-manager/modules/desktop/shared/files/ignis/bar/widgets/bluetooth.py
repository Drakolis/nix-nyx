from ignis import widgets

from ignis.services.bluetooth import BluetoothService

bluetooth = BluetoothService.get_default()

# TODO: Subscribe OSD for device_added/remove_device events

icon_active = "bluetooth-active-symbolic"
icon_disabled = "bluetooth-disabled-symbolic"
icon_disconnected = "bluetooth-disconnected-symbolic"
icon_hardware_disabled = "bluetooth-hardware-disabled-symbolic"
icon_paired = "bluetooth-paired-symbolic"

def bluetooth_render_contents(connected_devices, powered, state, setup_mode):
  icon = "bluetooth-symbolic"

  match state:
    case "absent":
      icon = icon_hardware_disabled
    case "on":
      icon = icon_active
      if setup_mode:
        icon = icon_active
      if len(connected_devices) > 0:
        icon = icon_paired
    case "turning-on":
      icon = icon_disconnected
    case "turning-off" | "off":
      icon = icon_disabled

  if not powered:
    icon = icon_disabled

  return [
    widgets.Icon(
      css_classes=["bluetooth-label"],
      image=icon,
      pixel_size=24,
      hexpand=True,
    ),
  ]


def bluetooth_status() -> widgets.Button:
  on_click_handler = lambda self: True

  bluetooth_widgets = bluetooth.bind_many(
    ["connected_devices", "powered", "state", "setup_mode"], bluetooth_render_contents
  )

  return widgets.Button(
    css_classes=["pill-button"],
    on_right_click=on_click_handler,
    child=widgets.Box(spacing=5, child=bluetooth_widgets),
  )
