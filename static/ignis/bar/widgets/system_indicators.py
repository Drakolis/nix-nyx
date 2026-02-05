from ignis import widgets
from ignis.services.upower import UPowerService

upower = UPowerService.get_default()

TRAY_ITEM_SPACING = 3


def system_indicators_widget() -> widgets.Box:
  return widgets.Box(
    css_classes=["bar-pill", "elevation1"],
    spacing=TRAY_ITEM_SPACING,
    child=[
      widgets.EventBox(
        css_classes=["pill-icon-button"],
        child=[
          widgets.Icon(
            css_classes=["clock-label"],
            image="clock-applet-symbolic",
            pixel_size=24,
            hexpand=True,
          ),
        ],
      ),
      widgets.EventBox(
        css_classes=["pill-icon-button"],
        child=[
          widgets.Icon(
            css_classes=["clock-label"],
            image="clock-applet-symbolic",
            pixel_size=24,
            hexpand=True,
          ),
        ],
      ),
      widgets.EventBox(
        css_classes=["pill-icon-button"],
        child=[
          widgets.Icon(
            css_classes=["clock-label"],
            image="clock-applet-symbolic",
            pixel_size=24,
            hexpand=True,
          ),
        ],
      ),
      widgets.EventBox(
        css_classes=["pill-icon-button"],
        child=[
          widgets.Icon(
            css_classes=["clock-label"],
            image="clock-applet-symbolic",
            pixel_size=24,
            hexpand=True,
          ),
        ],
      ),
      widgets.EventBox(
        css_classes=["pill-icon-button"],
        child=[
          widgets.Icon(
            css_classes=["clock-label"],
            image="clock-applet-symbolic",
            pixel_size=24,
            hexpand=True,
          ),
        ],
      ),
      widgets.Box(
        css_classes=["pill-icon-button"],
        child=[
          widgets.Icon(
            css_classes=["clock-label"],
            image="clock-applet-symbolic",
            pixel_size=24,
            hexpand=True,
          ),
        ],
      ),
    ],
  )
