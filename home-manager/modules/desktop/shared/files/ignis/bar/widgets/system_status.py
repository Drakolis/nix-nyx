from ignis import widgets

from .brightness import MonitorStatusWidget
from .audio import AudioStatusWidget
from .keyboard import keyboard_status
from .network import NetworkStatusWidget
from .bluetooth import BluetoothStatusWidget
from .power import PowerStatusWidget

from ignis.services.upower import UPowerService

upower = UPowerService.get_default()

TRAY_ITEM_SPACING = 3


def system_status_widget(monitor_id: int) -> widgets.Box:
  return widgets.Box(
    css_classes=["bar-pill", "elevation1"],
    spacing=TRAY_ITEM_SPACING,
    child=[
      keyboard_status(),
      AudioStatusWidget(True),
      AudioStatusWidget(False),
      MonitorStatusWidget(monitor_id),
      PowerStatusWidget()
      if upower.is_available and len(upower.batteries) > 0
      else None,
      NetworkStatusWidget(),
      BluetoothStatusWidget(),
    ],
  )
