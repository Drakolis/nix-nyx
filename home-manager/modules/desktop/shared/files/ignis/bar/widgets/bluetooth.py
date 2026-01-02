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
  label = "BTH"
  icon = "bluetooth-symbolic"

  match state:
    case "absent":
      label = "N/A"
      icon = icon_hardware_disabled
    case "on":
      label = "ON"
      icon = icon_active
      if setup_mode:
        label = "RDY"
        icon = icon_active
      if len(connected_devices)>0:
        label = f"{len(connected_devices)} DEV"
        icon = icon_paired
    case "turning-on":
      label = "BOOT"
      icon = icon_disconnected
    case "turning-off" |  "off":
      label = "OFF"
      icon = icon_disabled

  if not powered:
    label = "OFF"

  return [
    widgets.Icon(
      css_classes=["bluetooth-label"],
      image=icon,
      pixel_size=16,
    ),
    widgets.Label(
      css_classes=["bluetooth-label", "label-bar"],
      label=label,
    ),
  ]

def bluetooth_status() -> widgets.EventBox:
  on_click_handler = lambda self: True

  bluetooth_widgets = bluetooth.bind_many(
    ["connected_devices", "powered", "state", "setup_mode"],
    bluetooth_render_contents
  )

  return widgets.EventBox(
    on_right_click=on_click_handler,
    spacing=5,
    child=bluetooth_widgets,
  )
