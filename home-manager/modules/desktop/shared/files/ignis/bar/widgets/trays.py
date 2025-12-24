from ignis import widgets

from ignis.services.system_tray import SystemTrayService, SystemTrayItem

from .brightness import brightness_status
from .audio import audio_input_status, audio_output_status
from .keyboard import keyboard_status

system_tray_service = SystemTrayService.get_default()


def system_tray_item(item: SystemTrayItem) -> widgets.Button:
    if item.menu:
        menu = item.menu.copy()
    else:
        menu = None

    return widgets.Button(
        child=widgets.Box(
            child=[
                widgets.Icon(image=item.bind("icon"), pixel_size=16),
                menu,
            ],
        ),
        setup=lambda self: item.connect("removed", lambda x: self.unparent()),
        tooltip_text=item.bind("tooltip"),
        on_click=lambda x: menu.popup() if menu else None,
        on_right_click=lambda x: menu.popup() if menu else None,
        css_classes=["tray-item"],
    )


def system_tray() -> widgets.Box:
    return widgets.Box(
        css_classes=["bar-pill"],
        setup=lambda self: system_tray_service.connect(
            "added", lambda x, item: self.append(system_tray_item(item))
        ),
        spacing=5,
    )


def status_tray() -> widgets.Box:
    return widgets.Box(
        css_classes=["bar-pill"],
        spacing=7,
        child=[
            keyboard_status(),
            audio_output_status(),
            audio_input_status(),
            brightness_status(),
            # power_status(),
            # network_status(),
            # bluetooth_status(),
        ],
    )
