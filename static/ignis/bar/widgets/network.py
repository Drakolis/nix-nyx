import asyncio

from ignis import widgets
from ignis.services.network import NetworkService

from widgets.setup_menu import (
  SetupMenuHeader,
  SetupMenuItemButton,
  SetupMenuItemIconButton,
  SetupMenuItemSeparator,
  SetupMenuPopover,
)

# TODO: Subscribe OSD for new_device/remove_device events
DEFAULT_ICON = "network-disconnected-symbolic"
DEFAULT_LABEL = "N/A"


def get_access_point_title(access_point):
  name = access_point.ssid if access_point.ssid else access_point.bssid
  frequency = f"{round(access_point.frequency / 1000, 1)}GHz"
  return f"{name} ({frequency})"


class NetworkSetupAccessPointItem(SetupMenuItemIconButton):
  def __init__(self, access_point):
    self.access_point = access_point
    self.connected = access_point.is_connected
    description = get_access_point_title(access_point)

    on_click = lambda x: asyncio.create_task(self.sync_connect())
    setup_button = lambda self: self.access_point.connect(
      "removed", lambda x: self.unparent()
    )

    super().__init__(
      setup_button=setup_button,
      on_click=on_click,
      label=description,
      icon=self.access_point.icon_name,
      is_active=self.connected,
      active_css_class="network-active",
    )

    self.access_point.connect(
      "notify::is-connected", lambda x, y: self.update_connected(x)
    )
    self.update_connected(self.access_point)

  def update_connected(self, access_point):
    self.connected = access_point.is_connected
    self.set_active(access_point.is_connected)

  async def sync_connect(self):
    self.set_icon("process-working-symbolic")
    self.add_icon_class("animation-spin")
    if self.connected:
      await self.access_point.disconnect_from()
    else:
      await self.access_point.connect_to_graphical()
    self.reset_icon()
    self.reset_icon_class()


class NetworkStatusWidget(widgets.Box):
  def __init__(self):
    self.network = NetworkService.get_default()
    self.wifi_device = self.network.wifi.devices[0]
    self.show_wifi = False

    self.network_setup_menu_header = SetupMenuHeader(
      title="Network",
      subtitle="Network Name",
    )

    self.network_setup_networks = widgets.Box(vertical=True)

    self.network_setup_hideable = [
      SetupMenuItemSeparator(),
      widgets.Scroll(
        child=self.network_setup_networks,
        min_content_height=50,
        max_content_height=250,
        propagate_natural_height=True,
      ),
    ]

    self.network_setup_menu = SetupMenuPopover(
      child=[
        self.network_setup_menu_header,
        *self.network_setup_hideable,
        SetupMenuItemSeparator(),
        SetupMenuItemButton(
          on_click=lambda x: asyncio.create_task(self.wifi_device.scan()),
          label="Search for Networks...",
        ),
        # SetupMenuItemButton(
        #   on_click=lambda x: self.__start_discovery(), label="Network Settings..."
        # ),
      ],
    )

    self.network_status_icon = widgets.Icon(
      css_classes=["network-label"],
      image=DEFAULT_ICON,
      pixel_size=24,
      hexpand=True,
    )

    self.network_bar_item = widgets.Button(
      css_classes=["pill-icon-button"],
      on_click=lambda x: self.network_setup_menu.popup(),
      on_right_click=self.__toggle_wifi,
      child=self.network_status_icon,
    )

    super().__init__(child=[self.network_bar_item, self.network_setup_menu])

    self.network.ethernet.connect(
      "notify::is-connected", lambda x, _: self.__update_ethernet(x)
    )
    self.network.wifi.connect(
      "notify::is-connected", lambda x, _: self.__update_wifi(x)
    )
    self.network.wifi.connect("notify::enabled", lambda x, _: self.__update_wifi(x))

    self.wifi_device.connect("notify::ap", lambda x, y: self.__update_wifi_device(x))
    self.wifi_device.connect(
      "new-access-point", lambda x, y: self.__append_access_point(y)
    )

    self.__update_ethernet(self.network.ethernet)
    self.__update_wifi(self.network.wifi)
    self.__update_wifi_device(self.wifi_device)
    [self.__append_access_point(ap) for ap in self.wifi_device.access_points]

  def __update_ethernet(self, ethernet):
    ethernet_icon = ethernet.icon_name

    if not self.show_wifi:
      self.network_status_icon.set_image(ethernet_icon)

  def __update_wifi(self, wifi):
    if self.show_wifi:
      wifi_icon = (
        wifi.icon_name
        if wifi.enabled
        else "network-wireless-hardware-disabled-symbolic"
      )

      self.network_status_icon.set_image(wifi_icon)
    self.show_wifi = wifi.enabled

  def __update_wifi_device(self, wifi_device):
    self.network_setup_menu_header.set_subtitle(get_access_point_title(wifi_device.ap))
    # TODO: Weird behaviour for when network is offline

  def __toggle_wifi(self, wifi):
    self.network.wifi.enabled = not self.network.wifi.enabled

  def __append_access_point(self, access_point):
    self.network_setup_networks.append(
      NetworkSetupAccessPointItem(
        access_point,
      )
    )
