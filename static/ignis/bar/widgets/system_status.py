from ignis import widgets
from ignis.services.upower import UPowerService

from .audio import AudioStatusWidget
from .bluetooth import BluetoothStatusWidget
from .brightness import MonitorStatusWidget
from .keyboard import keyboard_status
from .network import NetworkStatusWidget
from .power import PowerStatusWidget

upower = UPowerService.get_default()


def system_status_widget(monitor_id: int) -> widgets.Box:
  return widgets.Box(
    css_classes=["bar-pill", "elevation1"],
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
