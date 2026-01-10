import asyncio
from ignis import widgets

from ignis.services.bluetooth import BluetoothService

from widgets.setup_menu import (
  SetupMenuPopover,
  SetupMenuHeader,
  SetupMenuItemSeparator,
  SetupMenuItemButton,
  SetupMenuItemIconButton,
)

# TODO: Subscribe OSD for device_added/remove_device events

icon_active = "bluetooth-active-symbolic"
icon_disabled = "bluetooth-disabled-symbolic"
icon_disconnected = "bluetooth-disconnected-symbolic"
icon_hardware_disabled = "bluetooth-hardware-disabled-symbolic"
icon_paired = "bluetooth-paired-symbolic"


class BluetoothSetupDeviceItem(SetupMenuItemIconButton):
  def __init__(self, device):
    self.device = device
    self.connected = device.connected

    description = device.alias
    address = device.address
    icon = f"{device.icon_name}-symbolic"

    on_click = lambda x: asyncio.create_task(self.sync_connect())
    setup_button = lambda self: device.connect("removed", lambda x: self.unparent())

    super().__init__(
      setup_button=setup_button,
      on_click=on_click,
      label=description,
      icon=icon,
      is_active=self.connected,
      active_css_class="bluetooth-active",
    )

    device.connect("notify::connected", lambda x, y: self.update_connected(x))
    self.update_connected(self.device)

  def update_connected(self, device):
    self.connected = device.connected
    self.set_active(device.connected)

  async def sync_connect(self):
    self.set_icon("process-working-symbolic")
    self.add_icon_class("animation-spin")
    if self.connected:
      await self.device.disconnect_from()
    else:
      await self.device.connect_to()
    self.reset_icon()
    self.reset_icon_class()


class BluetoothStatusWidget(widgets.Box):
  def __init__(self):
    self.bluetooth = BluetoothService.get_default()

    self.bluetooth_setup_menu_header = SetupMenuHeader(
      title="Bluetooth",
      subtitle="Device Name",
    )

    self.bluetooth_setup_devices = widgets.Box(vertical=True)

    self.bluetooth_setup_menu = SetupMenuPopover(
      child=[
        self.bluetooth_setup_menu_header,
        SetupMenuItemSeparator(),
        widgets.Scroll(
          child=self.bluetooth_setup_devices,
          min_content_height=50,
          max_content_height=250,
          propagate_natural_height=True,
        ),
        SetupMenuItemSeparator(),
        SetupMenuItemButton(
          on_click=lambda x: self.__start_discovery(), label="Start discovery..."
        ),
      ],
    )

    self.bluetooth_icon = widgets.Icon(
      css_classes=["bluetooth-label"],
      image=icon_disconnected,
      pixel_size=24,
      hexpand=True,
    )

    self.bluetooth_bar_item = widgets.Button(
      css_classes=["pill-button"],
      on_click=lambda x: self.bluetooth_setup_menu.popup(),
      on_right_click=self.__toggle_bluetooth,
      child=self.bluetooth_icon,
    )

    super().__init__(child=[self.bluetooth_bar_item, self.bluetooth_setup_menu])

    self.bluetooth.connect(
      "notify::connected-devices", lambda x, y: self.__update_bluetooth_status(x)
    )
    self.bluetooth.connect(
      "notify::powered", lambda x, y: self.__update_bluetooth_status(x)
    )
    self.bluetooth.connect(
      "notify::state", lambda x, y: self.__update_bluetooth_status(x)
    )
    self.bluetooth.connect(
      "notify::setup-mode", lambda x, y: self.__update_bluetooth_status(x)
    )
    self.bluetooth.connect(
      "device-added", lambda x, y: self.__append_bluetooth_device(y)
    )

  def __start_discovery(self, *args):
    self.bluetooth.set_setup_mode(True)

  def __toggle_bluetooth(self, *args):
    self.bluetooth.powered = not self.bluetooth.powered

  def __update_bluetooth_status(self, bluetooth_service):
    icon = "bluetooth-symbolic"
    label = "Turned On"

    match bluetooth_service.state:
      case "absent":
        icon = icon_hardware_disabled
        label = "Turned Off"
      case "on":
        icon = icon_active
        if bluetooth_service.setup_mode:
          label = "Discovering..."
        elif len(bluetooth_service.connected_devices) > 0:
          icon = icon_paired
          label = "undefined"
          label = f"{len(bluetooth_service.connected_devices)} devices connected"
      case "turning-on":
        icon = icon_disconnected
      case "turning-off" | "off":
        icon = icon_disabled
        label = "Turned Off"

    if not bluetooth_service.powered:
      icon = icon_disabled
      label = "Turned Off"

    self.bluetooth_icon.image = icon
    self.bluetooth_setup_menu_header.set_subtitle(label)

  def __append_bluetooth_device(self, bluetooth_device):
    self.bluetooth_setup_devices.append(
      BluetoothSetupDeviceItem(
        bluetooth_device,
      )
    )
