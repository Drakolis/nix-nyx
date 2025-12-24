from ignis import widgets

from ignis.services.audio import AudioService

from utils import (
    get_audio_input_status_icon,
    get_audio_output_status_icon,
)

audio_service = AudioService.get_default()


def audio_render_widgets(volume, is_muted, is_output):
    icon = ""

    if is_output:
        icon = get_audio_output_status_icon(volume, is_muted)
    else:
        icon = get_audio_input_status_icon(volume, is_muted)

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
    ]


def audio_output_status() -> widgets.Button:
    audio_output_widgets = audio_service.speaker.bind_many(
        ["volume", "is_muted"],
        lambda v, m: audio_render_widgets(v, m, True),
    )
    return widgets.Button(
        # on_click=on_click_handler,
        child=widgets.Box(
            spacing=2,
            child=audio_output_widgets,
        ),
    )


def audio_input_status() -> widgets.Button:
    audio_input_widgets = audio_service.microphone.bind_many(
        ["volume", "is_muted"],
        lambda v, m: audio_render_widgets(v, m, False),
    )
    return widgets.Button(
        # on_click=on_click_handler,
        child=widgets.Box(
            spacing=2,
            child=audio_input_widgets,
        ),
    )
