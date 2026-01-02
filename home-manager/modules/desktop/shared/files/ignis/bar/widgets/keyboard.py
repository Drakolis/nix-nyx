from ignis import widgets

from ignis.services.hyprland import HyprlandService
from ignis.services.niri import NiriService

hyprland = HyprlandService.get_default()
niri = NiriService.get_default()

def map_layout(layout: str) -> str:
  if "English" in layout:
    return "ENG"
  elif "Russian" in layout:
    return "RUS"
  elif "German" in layout:
    return "DEU"
  return "UNK"


def keyboard_status() -> widgets.Button:
  on_click_handler = lambda self: True
  layout_label = "N/A"

  if hyprland.is_available:
    on_click_handler = lambda self: hyprland.main_keyboard.switch_layout("next")
    layout_label = hyprland.main_keyboard.bind("active_keymap", map_layout)
  elif niri.is_available:
    on_click_handler = lambda self: niri.switch_kb_layout()
    layout_label = niri.keyboard_layouts.bind("current_name", map_layout)

  return widgets.Button(
    on_click=on_click_handler,
    child=widgets.Box(
      spacing=5,
      child=[
        widgets.Icon(
          css_classes=["layout-label"],
          image="input-keyboard-symbolic",
          pixel_size=16,
        ),
        widgets.Label(
          css_classes=["layout-label", "label-bar"],
          label=layout_label,
        ),
      ]
    ),
  )
