from ignis import widgets

from ignis.services.system_tray import SystemTrayService, SystemTrayItem
from ignis.window_manager import WindowManager

system_tray_service = SystemTrayService.get_default()
window_manager = WindowManager.get_default()

TRAY_ITEM_SPACING = 3


def system_tray_item(item: SystemTrayItem) -> widgets.Button:
  if item.menu:
    menu = item.menu.copy()
  else:
    menu = None

  return widgets.Button(
    css_classes=["pill-button"],
    child=widgets.Box(
      child=[
        widgets.Icon(
          css_classes=["tray-label"],
          image=item.bind("icon"),
          pixel_size=24,
          hexpand=True,
        ),
        menu,
      ],
    ),
    setup=lambda self: item.connect("removed", lambda x: self.unparent()),
    tooltip_text=item.bind("tooltip"),
    on_click=lambda x: menu.popup() if menu else None,
    on_right_click=lambda x: menu.popup() if menu else None,
  )


def system_tray_widget() -> widgets.Box:
  return widgets.Box(
    css_classes=["bar-pill", "elevation1"],
    setup=lambda self: system_tray_service.connect(
      "added", lambda x, item: self.append(system_tray_item(item))
    ),
    spacing=TRAY_ITEM_SPACING,
  )
