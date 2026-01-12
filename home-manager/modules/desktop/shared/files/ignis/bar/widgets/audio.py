import asyncio

from ignis import widgets
from ignis import utils

from ignis.services.audio import AudioService

from utils import (
  get_audio_device_icon,
  get_audio_input_status_icon,
  get_audio_output_status_icon,
)
from widgets.setup_menu import (
  SetupMenuPopover,
  SetupMenuHeader,
  SetupMenuItemScale,
  SetupMenuItemSeparator,
  SetupMenuItemButton,
  SetupMenuItemIconButton,
)

audio_service = AudioService.get_default()

DEFAULT_LABEL = "AUD"
DEFAULT_ICON = "speaker-symbolic"

MENU_LABEL_OUTPUT = "Speaker"
MENU_LABEL_INPUT = "Microphone"


def devices_item(device, default_device, on_click):
  description = device.description
  name = device.name
  icon = get_audio_device_icon(name)
  setup_button = lambda self: device.connect("removed", lambda x: self.unparent())
  setup_icon = lambda self: default_device.connect(
    "notify::name",
    lambda x, y: self.set_css_classes(
      ["setup-menu-button-icon", "audio-active" if x.name == name else None]
    ),
  )

  return SetupMenuItemIconButton(
    setup_button=setup_button,
    setup_icon=setup_icon,
    on_click=on_click,
    label=description,
    icon=icon,
  )


class AudioStatusWidget(widgets.Button):
  def __init__(self, is_output):
    self.audio_service = AudioService.get_default()
    self.audio_device = (
      audio_service.speaker if is_output else self.audio_service.microphone
    )
    self.audio_device_target = "speaker" if is_output else "microphone"
    self.is_output = is_output

    audio_setup_menu_header = SetupMenuHeader(
      title=MENU_LABEL_OUTPUT if is_output else MENU_LABEL_INPUT,
      subtitle="Device Name",
    )

    audio_setup_menu_scale = SetupMenuItemScale(
      icon_css_classes=["audio-label"],
      scale_css_class="audio-slider",
      icon_max="audio-volume-high-symbolic",
      icon_min="audio-volume-low-symbolic",
    )

    audio_setup_devices = widgets.Box(vertical=True)

    audio_setup_menu = SetupMenuPopover(
      child=[
        audio_setup_menu_header,
        audio_setup_menu_scale,
        SetupMenuItemSeparator(),
        audio_setup_devices,
        SetupMenuItemSeparator(),
        SetupMenuItemButton(
          on_click=lambda x: self.open_settings_app(), label="Sound Settings..."
        ),
        SetupMenuItemButton(
          on_click=lambda x: self.open_patchbay_app(), label="Patchbay Control..."
        ),
      ],
    )

    audio_status_contents = [
      widgets.Icon(
        css_classes=["audio-label"],
        image=DEFAULT_ICON,
        pixel_size=24,
        hexpand=True,
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
      "notify::is-muted", lambda x, y: self.update_audio_status(x)
    )
    self.audio_device.connect("notify::name", lambda x, y: self.update_audio_status(x))

    self.audio_service.connect(
      f"{self.audio_device_target}-added", lambda x, y: self.append_audio_device(y)
    )

    self.audio_status_contents = audio_status_contents
    self.audio_setup_menu = audio_setup_menu
    self.audio_setup_menu_header = audio_setup_menu_header
    self.audio_setup_menu_scale = audio_setup_menu_scale
    self.audio_setup_devices = audio_setup_devices
    self.update_audio_status(self.audio_device)

  def open_settings_app(self):
    asyncio.create_task(utils.exec_sh_async("pavucontrol"))
    self.audio_setup_menu.popdown()

  def open_patchbay_app(self):
    asyncio.create_task(utils.exec_sh_async("helvum"))
    self.audio_setup_menu.popdown()

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

  def assign_default_device(self, device):
    setattr(self.audio_service, self.audio_device_target, device)

  def append_audio_device(self, audio_device):
    self.audio_setup_devices.append(
      devices_item(
        audio_device,
        self.audio_device,
        lambda _: self.assign_default_device(audio_device),
      )
    )

  @utils.debounce(100)
  def change_audio_debounced(self, device, value):
    device.set_volume(value)
