from ignis import widgets
from ignis.services.system_tray import SystemTrayItem, SystemTrayService
from ignis.window_manager import WindowManager

system_tray_service = SystemTrayService.get_default()
window_manager = WindowManager.get_default()

TRAY_ITEM_SPACING = 3


def system_tray_item(item: SystemTrayItem) -> widgets.Button:
  if item.menu:
    menu = item.menu.copy()
  else:
    menu = None

  return widgets.Box(
    setup=lambda self: item.connect("removed", lambda x: self.unparent()),
    child=[
      widgets.EventBox(
        tooltip_text=item.bind("tooltip"),
        on_click=lambda x: menu.popup() if menu else None,
        on_right_click=lambda x: menu.popup() if menu else None,
        css_classes=["pill-icon-button"],
        child=[
          widgets.Icon(
            css_classes=["tray-label"],
            image=item.bind("icon"),
            pixel_size=24,
            hexpand=True,
          ),
        ],
      ),
      menu,
    ],
  )


def system_tray_widget() -> widgets.Box:
  return widgets.Box(
    css_classes=["bar-pill", "elevation1"],
    setup=lambda self: system_tray_service.connect(
      "added", lambda x, item: self.append(system_tray_item(item))
    ),
    spacing=TRAY_ITEM_SPACING,
  )
