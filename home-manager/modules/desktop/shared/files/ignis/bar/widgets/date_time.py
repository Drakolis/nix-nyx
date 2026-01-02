import datetime

from ignis import widgets
from ignis import utils

def date_time_widget() -> widgets.Box:
  # poll for current time every second
  return widgets.Box(
    css_classes=["bar-pill", "elevation1"],
    spacing=5,
    child=[
      widgets.Icon(
        css_classes=["clock-label"],
        image="clock-applet-symbolic",
        pixel_size=16,
      ),
      widgets.Label(
        css_classes=["clock-label", "label-bar"],
        label=utils.Poll(
          1_000,
          lambda self: datetime.datetime.now().strftime("%H:%M:%S, %a %d.%b"),
        ).bind("output"),
      ),
    ],
  )
