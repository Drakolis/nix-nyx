import datetime

from ignis import widgets
from ignis import utils

from ignis.window_manager import WindowManager

window_manager = WindowManager.get_default()


def date_time_widget() -> widgets.Box:
  # poll for current time every second
  return widgets.Box(
    css_classes=["bar-pill", "elevation1"],
    child=[
      widgets.Button(
        on_click=lambda x: window_manager.toggle_window("eggshell_info_center"),
        css_classes=["pill-button"],
        child=widgets.Box(
          spacing=3,
          child=[
            widgets.Icon(
              css_classes=["clock-label"],
              image="clock-applet-symbolic",
              pixel_size=24,
              hexpand=True,
            ),
            widgets.Label(
              css_classes=["clock-label", "label-bar"],
              label=utils.Poll(
                1_000,
                lambda self: datetime.datetime.now().strftime("%H:%M:%S, %a %d.%b"),
              ).bind("output"),
            ),
          ],
        ),
      )
    ],
  )
