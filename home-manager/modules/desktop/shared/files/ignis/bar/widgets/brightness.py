from ignis import widgets
from ignis.services.backlight import BacklightService
from utils import (
    get_brightness_status_icon,
)
from widgets import Popover

backlight = BacklightService.get_default()

menu = Popover(
    child=widgets.EventBox(
        css_classes=["popup", "elevation2"],
        child=[
            widgets.Label(
                halign="start",
                css_classes=["title-medium"],
                label="Screen settings",
            ),
            widgets.Box(hexpand=True, css_classes=["control"]),
            widgets.Box(
                hexpand=True,
                css_classes=["control"],
                spacing=8,
                child=[
                    widgets.Button(
                        css_classes=["control-button", "elevation1"],
                        child=widgets.Icon(
                            image="accessories-screenshot-symbolic", pixel_size=28
                        ),
                    ),
                    widgets.Button(
                        css_classes=["control-button", "elevation1"],
                        child=widgets.Icon(
                            image="user-desktop-symbolic", pixel_size=28
                        ),
                    ),
                    widgets.Button(
                        css_classes=["control-button", "elevation1"],
                        child=widgets.Icon(
                            image="screen-shared-symbolic", pixel_size=28
                        ),
                    ),
                    widgets.Button(
                        css_classes=["control-button", "elevation1"],
                        child=widgets.Icon(
                            image="redshift-status-on-symbolic", pixel_size=28
                        ),
                    ),
                ],
            ),
        ],
        vertical=True,
        width_request=256,
        spacing=8,
    )
)


def brightness_render_widgets(brightness, brightness_max):
    brightness_percent = round(100 * (brightness / brightness_max))
    return [
        widgets.Icon(
            css_classes=["brightness-label"],
            image=get_brightness_status_icon(brightness_percent),
            pixel_size=16,
        ),
        widgets.Label(
            css_classes=["brightness-label", "label-bar"],
            label=f"{brightness_percent}%",
        ),
        menu,
    ]


def brightness_status() -> widgets.Button:
    brightness_widgets = backlight.bind_many(
        ["brightness", "max_brightness"],
        brightness_render_widgets,
    )

    return widgets.Button(
        on_click=lambda x: menu.popup(),
        child=widgets.Box(spacing=2, child=brightness_widgets),
    )
