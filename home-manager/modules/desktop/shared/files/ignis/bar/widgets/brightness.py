from ignis import widgets
from ignis import utils

from ignis.services.backlight import BacklightService

from utils import (
  get_brightness_status_icon,
)
from widgets.setup_menu import SetupMenuPopover, SetupMenuHeader, SetupMenuItemScale

# TODO: Should know which display is being controlled

backlight = BacklightService.get_default()

menu_header = SetupMenuHeader(
  title="Monitor",
  subtitle="Resolution",
)

scale_menu_item = SetupMenuItemScale(
  icon_css_classes=["brightness-label"],
  icon_max="display-brightness-high-symbolic",
  icon_min="display-brightness-low-symbolic",
  scale_css_class="brightness-slider",
)

menu = SetupMenuPopover(
  child=[
    menu_header,
    scale_menu_item,
  ],
)


def brightness_render_contents(available, brightness, brightness_max):
  brightness_percentage = round(100 * (brightness / brightness_max))
  brightness_percent = brightness_max / 100
  brightness_icon = (
    get_brightness_status_icon(brightness_percentage)
    if available
    else "video-display-symbolic"
  )

  scale_menu_item.set_value(brightness_percentage)
  scale_menu_item.set_on_change(
    lambda x: backlight.set_brightness_async(x.get_value() * brightness_percent)
  )

  scale_menu_item.set_visible(available)

  return [
    widgets.Icon(
      css_classes=["brightness-label"],
      image=brightness_icon,
      pixel_size=24,
      hexpand=True,
    ),
    menu,
  ]


def brightness_status(monitor_id: int) -> widgets.Button:
  brightness_widgets = backlight.bind_many(
    ["available", "brightness", "max_brightness"],
    brightness_render_contents,
  )
  current_monitor = utils.get_monitor(monitor_id)
  menu_header.set_title(
    f"{current_monitor.get_model()} ({current_monitor.get_connector()})"
  )
  menu_header.set_subtitle(
    f"{current_monitor.get_geometry().width} x {current_monitor.get_geometry().height} px ({current_monitor.get_refresh_rate() / 1000} Hz)"
  )

  return widgets.Button(
    css_classes=["pill-button"],
    on_click=lambda x: menu.popup(),
    child=widgets.Box(spacing=5, child=brightness_widgets),
  )
