from ignis import widgets

from .brightness import brightness_status
from .audio import audio_input_status, audio_output_status
from .keyboard import keyboard_status
from .network import network_status
from .bluetooth import bluetooth_status
from .power import power_status

TRAY_ITEM_SPACING = 10

def system_status_widget(monitor_id: int) -> widgets.Box:

  return widgets.Box(
    css_classes=["bar-pill", "elevation1"],
    spacing=TRAY_ITEM_SPACING,
    child=[
      keyboard_status(),
      audio_output_status(),
      audio_input_status(),
      brightness_status(monitor_id),
      power_status(),
      network_status(),
      bluetooth_status(),
    ],
  )
