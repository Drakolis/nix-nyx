from ignis import widgets
from ignis import utils

from ignis.services.audio import AudioService

from utils import (
  get_audio_input_status_icon,
  get_audio_output_status_icon,
)
from widgets.setup_menu import SetupMenuPopover, SetupMenuHeader, ScaleSetupMenuItem

audio_service = AudioService.get_default()

DEFAULT_LABEL = "AUD"
DEFAULT_ICON = "speaker-symbolic"

MENU_LABEL_OUTPUT = "Speakers"
MENU_LABEL_INPUT = "Microphone"


class AudioStatusWidget(widgets.Button):
  def __init__(self, is_output):
    self.audio_service = AudioService.get_default()
    self.audio_device = (
      audio_service.speaker if is_output else self.audio_service.microphone
    )
    self.audio_devices = (
      audio_service.speakers if is_output else self.audio_service.microphones
    )
    self.is_output = is_output

    audio_setup_menu_header = SetupMenuHeader(
      title=MENU_LABEL_OUTPUT if is_output else MENU_LABEL_INPUT,
      subtitle="Device Name",
    )

    audio_setup_menu_scale = ScaleSetupMenuItem(
      icon_css_classes=["audio-label"],
      scale_css_class="audio-slider",
      icon_max="audio-volume-high-symbolic",
      icon_min="audio-volume-low-symbolic",
    )

    audio_setup_menu = SetupMenuPopover(
      child=[
        audio_setup_menu_header,
        audio_setup_menu_scale,
      ],
    )

    audio_status_contents = [
      widgets.Icon(
        css_classes=["audio-label"],
        image=DEFAULT_ICON,
        pixel_size=18,
      ),
      audio_setup_menu,
    ]

    super().__init__(
      css_classes=["pill-button"],
      on_click=lambda x: audio_setup_menu.popup(),
      child=widgets.Box(
        child=audio_status_contents,
        spacing=5,
      ),
      on_right_click=lambda _: self.audio_device.set_is_muted(
        not self.audio_device.is_muted
      ),
    )

    self.audio_device.connect(
      "notify::volume", lambda x, y: self.update_audio_status(x)
    )
    self.audio_device.connect(
      "notify::is_muted", lambda x, y: self.update_audio_status(x)
    )
    self.audio_device.connect("notify::name", lambda x, y: self.update_audio_status(x))

    self.audio_status_contents = audio_status_contents
    self.audio_setup_menu = audio_setup_menu
    self.audio_setup_menu_header = audio_setup_menu_header
    self.audio_setup_menu_scale = audio_setup_menu_scale
    self.update_audio_status(self.audio_device)

  def update_audio_status(self, device):
    volume = device.volume
    is_muted = device.is_muted
    name = device.description

    if self.is_output:
      icon = get_audio_output_status_icon(volume, is_muted)
    else:
      icon = get_audio_input_status_icon(volume, is_muted)

    self.audio_status_contents[0].image = icon

    self.audio_setup_menu_header.set_subtitle(name)
    self.audio_setup_menu_scale.set_value(volume)
    self.audio_setup_menu_scale.set_on_change(
      lambda v: self.change_audio_debounced(device, v.value)
    )

  @utils.debounce(100)
  def change_audio_debounced(self, device, value):
    device.set_volume(value)
# audio-card-symbolic.svg
# audio-card-usb-symbolic.svg
# audio-headphones-symbolic.svg
# audio-headset-symbolic.svg
# audio-input-microphone-symbolic.svg
# audio-speakers-symbolic.svg
