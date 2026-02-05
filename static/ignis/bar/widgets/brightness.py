import asyncio

from ignis import utils, widgets
from ignis.services.backlight import BacklightService
from ignis.services.recorder import RecorderConfig, RecorderService

from utils import (
  get_brightness_status_icon,
)
from widgets.setup_menu import (
  SetupMenuHeader,
  SetupMenuItemButton,
  SetupMenuItemScale,
  SetupMenuItemSeparator,
  SetupMenuPopover,
)


class MonitorStatusWidget(widgets.Box):
  def __init__(self, monitor_id):
    # TODO: Should know which display is being controlled
    self.backlight = BacklightService.get_default()
    self.recorder = RecorderService.get_default()

    self.monitor_menu_header = SetupMenuHeader(
      title="Monitor",
      subtitle="Resolution",
    )

    current_monitor = utils.get_monitor(monitor_id)
    self.monitor_menu_header.set_title(
      f"{current_monitor.get_model()} ({current_monitor.get_connector()})"
    )
    self.monitor_menu_header.set_subtitle(
      f"{current_monitor.get_geometry().width} x {current_monitor.get_geometry().height} px ({current_monitor.get_refresh_rate() / 1000} Hz)"
    )

    self.monitor_brightness_menu_item = SetupMenuItemScale(
      icon_css_classes=["brightness-label"],
      icon_max="display-brightness-high-symbolic",
      icon_min="display-brightness-low-symbolic",
      scale_css_class="brightness-slider",
    )

    self.monitor_record_button = SetupMenuItemButton(
      on_click=self.__start_recording,
      label="Start screen recording...",
    )
    self.monitor_record_end_button = SetupMenuItemButton(
      on_click=self.__stop_recording,
      label="Stop screen recording",
    )

    self.monitor_setup_menu = SetupMenuPopover(
      child=[
        self.monitor_menu_header,
        self.monitor_brightness_menu_item,
        SetupMenuItemSeparator(),
        self.monitor_record_button,
        self.monitor_record_end_button,
      ],
    )

    self.monitor_bar_icon = widgets.Icon(
      css_classes=["brightness-label"],
      image="video-display-symbolic",
      pixel_size=24,
      hexpand=True,
    )

    self.monitor_bar_item = widgets.Button(
      css_classes=["pill-icon-button"],
      on_click=lambda x: self.monitor_setup_menu.popup(),
      child=widgets.Box(spacing=5, child=[self.monitor_bar_icon]),
    )

    super().__init__(child=[self.monitor_bar_item, self.monitor_setup_menu])

    self.backlight.connect("notify::available", lambda x, y: self.__update_backlight(x))
    self.backlight.connect(
      "notify::brightness", lambda x, y: self.__update_backlight(x)
    )
    self.backlight.connect(
      "notify::max-brightness", lambda x, y: self.__update_backlight(x)
    )
    self.recorder.connect("notify::active", lambda x, y: self.__update_recorder(x))

    self.__update_backlight(self.backlight)
    self.__update_recorder(self.recorder)

  def __start_recording(self, *args):
    asyncio.create_task(
      self.recorder.start_recording(
        RecorderConfig(
          source="portal",
          path="Videos/Screencasts/Screencast from %Y-%m-%d_%H-%M-%S.mp4",
        )
      )
    )

  def __stop_recording(self, *args):
    self.recorder.stop_recording()

  def __update_recorder(self, recorder):
    self.monitor_record_button.visible = not recorder.active
    self.monitor_record_end_button.visible = recorder.active

  def __update_backlight(self, backlight):
    available = backlight.available
    brightness = backlight.brightness
    max_brightness = backlight.max_brightness

    self.monitor_brightness_menu_item.set_visible(available)

    if available:
      brightness_percentage = round(100 * (brightness / max_brightness))
      brightness_percent = max_brightness / 100
      self.monitor_brightness_menu_item.set_value(brightness_percentage)
      self.monitor_brightness_menu_item.set_on_change(
        lambda x: self.change_brightness_debounced(
          backlight, x.get_value() * brightness_percent
        )
      )

      brightness_icon = get_brightness_status_icon(brightness_percentage)

      self.monitor_bar_icon.image = brightness_icon

  @utils.debounce(100)
  def change_brightness_debounced(self, backlight, value):
    backlight.set_brightness(value)
