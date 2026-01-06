from ignis import widgets

from .brightness import brightness_status
from .audio import AudioStatusWidget
from .keyboard import keyboard_status
from .network import NetworkStatusWidget
from .bluetooth import bluetooth_status
from .power import PowerStatusWidget

TRAY_ITEM_SPACING = 3


def system_status_widget(monitor_id: int) -> widgets.Box:
  return widgets.Box(
    css_classes=["bar-pill", "elevation1"],
    spacing=TRAY_ITEM_SPACING,
    child=[
      keyboard_status(),
      AudioStatusWidget(True),
      AudioStatusWidget(False),
      brightness_status(monitor_id),
      PowerStatusWidget(),
      NetworkStatusWidget(),
      bluetooth_status(),
    ],
  )
