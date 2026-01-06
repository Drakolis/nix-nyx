DEFAULT_OSD_ICON = "distributor-logo-nixos"

from ignis import widgets
from ignis import utils
from ignis.services.hyprland import HyprlandService, HyprlandWorkspace
from ignis.services.niri import NiriService, NiriWorkspace
from ignis.services.mpris import MprisService, MprisPlayer
from ignis.services.audio import AudioService
from ignis.services.backlight import BacklightService
from ignis.services.upower import UPowerService
from ignis.services.network import NetworkService

from utils import (
  get_audio_input_status_icon,
  get_audio_output_status_icon,
  get_brightness_status_icon,
)

import simpleaudio as sa


# from ignis.services.bluetooth import AudioService
# from ignis.services.network import AudioService


class OSD(widgets.RevealerWindow):
  def __init__(self, monitor_id: int):
    self.monitor_id = monitor_id
    self.timeout = False
    self.label = "Nothing has happened"
    self.icon = DEFAULT_OSD_ICON
    self.show_scale = False
    self.scale_value = 0

    self.niri = NiriService.get_default()
    self.audio = AudioService.get_default()
    self.backlight = BacklightService.get_default()
    self.upower = UPowerService.get_default()
    self.network = NetworkService.get_default()

    icon_widget = widgets.Icon(
      image=self.icon,
      pixel_size=64,
    )
    label_widget = widgets.Label(
      css_classes=["title-medium"],
      label=self.label,
    )
    scale_widget = widgets.Scale(
      css_classes=["osd-slider", "slider-medium"],
      draw_value=False,
      vertical=False,
      value_pos="top",
      min=0,
      max=100,
      value=self.scale_value,
      visible=self.show_scale,
      sensitive=False,
    )

    revealer = widgets.Revealer(
      transition_type="crossfade",
      child=widgets.Box(
        css_classes=["osd-container", "sheet", "elevation3", "corner-large"],
        child=[icon_widget, label_widget, scale_widget],
        vertical=True,
        hexpand=True,
      ),
      transition_duration=300,
      reveal_child=True,
      hexpand=True,
    )

    container = widgets.Box(child=[revealer])

    super().__init__(
      visible=False,
      popup=True,
      layer="top",
      namespace=f"eggshell_osd_{monitor_id}",
      css_classes=["bar"],
      child=container,
      revealer=revealer,
    )

    self.niri.keyboard_layouts.connect(
      "notify::current-name", lambda x, y: self.trigger_layout(x)
    )
    self.audio.speaker.connect(
      "notify::volume", lambda x, y: self.trigger_volume(x, True)
    )
    self.audio.speaker.connect(
      "notify::is-muted", lambda x, y: self.trigger_muted(x, True)
    )
    self.audio.microphone.connect(
      "notify::volume", lambda x, y: self.trigger_volume(x, False)
    )
    self.audio.microphone.connect(
      "notify::is-muted", lambda x, y: self.trigger_muted(x, False)
    )
    self.backlight.connect(
      "notify::brightness", lambda x, y: self.trigger_brightness(x)
    )
    self.upower.display_device.connect(
      "notify::charging", lambda x, y: self.trigger_upower_device(x)
    )

    self.icon_widget = icon_widget
    self.label_widget = label_widget
    self.scale_widget = scale_widget

  def trigger(self):
    if self.timeout:
      self.timeout.cancel()
    self.icon_widget.set_image(self.icon)
    self.label_widget.set_label(self.label)

    if self.scale_widget.visible != self.show_scale:
      self.scale_widget.set_visible(self.show_scale)
    if self.show_scale:
      self.scale_widget.set_value(self.scale_value)

    self.set_visible(True)
    self.timeout = utils.Timeout(ms=750, target=lambda: self.set_visible(False))

  def trigger_layout(self, layout):
    self.label = f"Layout: {layout.current_name}"
    self.icon = "input-keyboard-symbolic"
    self.show_scale = False
    self.trigger()

  def trigger_volume(self, stream, is_output):
    self.label = f"Volume: {stream.volume}%"
    if is_output:
      self.icon = get_audio_output_status_icon(stream.volume, stream.is_muted)
    else:
      self.icon = get_audio_input_status_icon(stream.volume, stream.is_muted)

    self.show_scale = True
    self.scale_value = stream.volume
    self.trigger()

  def trigger_muted(self, stream, is_output):
    self.label = "Muted" if stream.is_muted else "Un-muted"
    if is_output:
      self.icon = get_audio_output_status_icon(stream.volume, stream.is_muted)
    else:
      self.icon = get_audio_input_status_icon(stream.volume, stream.is_muted)

    self.show_scale = False
    self.trigger()

  def trigger_upower_device(self, device):
    if device.charging:
      self.label = "Power Connected"
      self.icon = "battery-ac-adapter-symbolic"
      audio_file_path = "/home/drakolis/Projects/nix-nyx/home-manager/modules/desktop/shared/files/ignis/assets/sounds/charging.wav"
      wave_obj = sa.WaveObject.from_wave_file(audio_file_path)
      wave_obj.play()
      self.show_scale = False
      self.trigger()

  # MPRIS
  # Power/Battery
  # Low battery
  # Caffeine?
  # Network lost-connected
  # Bluetooth lost-connected
  # Performance warns

  def trigger_brightness(self, bs):
    brightness_percent = round(100 * (bs.brightness / bs.max_brightness))
    self.label = f"Brightness: {brightness_percent}%"
    self.icon = get_brightness_status_icon(brightness_percent)
    self.show_scale = True
    self.scale_value = brightness_percent
    self.trigger()
