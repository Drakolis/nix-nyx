from ignis import widgets

from ignis.services.audio import AudioService

from utils import (
  get_audio_input_status_icon,
  get_audio_output_status_icon,
)
from widgets.setup_menu import SetupMenuPopover, SetupMenuHeader, ScaleSetupMenuItem

audio_service = AudioService.get_default()

output_header = SetupMenuHeader(
  title="Speaker",
  subtitle="Name",
)

input_header = SetupMenuHeader(
  title="Microphone",
  subtitle="Name",
)

output_scale = ScaleSetupMenuItem(
  icon_css_classes=["audio-label"],
  icon_max="audio-volume-high-symbolic",
  icon_min="audio-volume-low-symbolic",
)

input_scale = ScaleSetupMenuItem(
  icon_css_classes=["audio-label"],
  icon_max="audio-volume-high-symbolic",
  icon_min="audio-volume-low-symbolic",
)

menu_output = SetupMenuPopover(
  child=[
    output_header,
    output_scale,
  ],
)

menu_input = SetupMenuPopover(
  child=[
    input_header,
    input_scale,
  ],
)

def audio_render_contents(volume, is_muted, name, is_output):
  icon = ""

  if is_output:
    icon = get_audio_output_status_icon(volume, is_muted)
    output_header.set_subtitle(name)
    output_scale.set_value(volume)
    output_scale.set_on_change(lambda v: audio_service.speaker.set_volume(v.value))
  else:
    icon = get_audio_input_status_icon(volume, is_muted)
    input_header.set_subtitle(name)
    input_scale.set_value(volume)
    input_scale.set_on_change(lambda v: audio_service.microphone.set_volume(v.value))

  return [
    widgets.Icon(
      css_classes=["audio-label"],
      image=icon,
      pixel_size=16,
    ),
    widgets.Label(
      css_classes=["audio-label", "label-bar"],
      label=f"{volume}%" if not is_muted else "Muted",
    ),
    menu_output if is_output else menu_input,
  ]


def audio_output_status() -> widgets.EventBox:
  audio_output_contents = audio_service.speaker.bind_many(
    ["volume", "is_muted", "description"],
    lambda v, m, n: audio_render_contents(v, m, n, True),
  )
  return widgets.Button(
    on_click=lambda x: menu_output.popup(),
    child=widgets.Box(spacing=5, child=audio_output_contents),
    on_right_click= lambda _ : audio_service.speaker.set_is_muted(not audio_service.speaker.is_muted)
    # on_scroll_up=audio_service.speaker
    # on_scroll_down=audio_service.speaker
  )


def audio_input_status() -> widgets.EventBox:
  audio_input_contents = audio_service.microphone.bind_many(
    ["volume", "is_muted", "description"],
    lambda v, m, n: audio_render_contents(v, m, n, False),
  )
  return widgets.Button(
    on_click=lambda x: menu_input.popup(),
    child=widgets.Box(spacing=5, child=audio_input_contents),
    on_right_click= lambda _ : audio_service.microphone.set_is_muted(not audio_service.microphone.is_muted)
    # on_scroll_up=audio_service.microphone
    # on_scroll_down=audio_service.microphone
  )
