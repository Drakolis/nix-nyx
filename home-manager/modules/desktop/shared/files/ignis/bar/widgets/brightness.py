from ignis import widgets
from ignis.services.backlight import BacklightService
from utils import (
    get_brightness_status_icon,
)

backlight = BacklightService.get_default()


def brightness_render_widgets(brightness, brightness_max):
    brightness_percent = round(100 * (brightness / brightness_max))
    return [
        widgets.Icon(
            css_classes=["brightness-label"],
            image=get_brightness_status_icon(brightness_percent),
            pixel_size=16,
        ),
        widgets.Label(
            css_classes=["brightness-label"],
            label=f"{brightness_percent}%",
        ),
    ]


def brightness_status() -> widgets.Button:
    brightness_widgets = backlight.bind_many(
        ["brightness", "max_brightness"],
        brightness_render_widgets,
    )

    return widgets.Button(
        # on_click=on_click_handler,
        child=widgets.Box(
            spacing=2,
            child=brightness_widgets,
        ),
    )
