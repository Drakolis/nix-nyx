from ignis import widgets
from ignis import utils

from ignis.menu_model import IgnisMenuModel, IgnisMenuItem, IgnisMenuSeparator

from ignis.services.hyprland import HyprlandService, HyprlandWorkspace
from ignis.services.niri import NiriService, NiriWorkspace

DEFAULT_WINDOW_TITLE = "Desktop"
DEFAULT_WINDOW_ICON = "show-desktop"


class WindowTitleWidget(widgets.Box):
  def __init__(self, monitor_id: int):
    self.title = DEFAULT_WINDOW_TITLE
    self.app_id = ""
    self.monitor_id = monitor_id

    self.hyprland = HyprlandService.get_default()
    self.niri = NiriService.get_default()

    icon_widget = widgets.Icon(
      css_classes=["window-icon"],
      pixel_size=18,
      # visible=niri.bind("active_output", lambda output: output == monitor_name),
    )

    label_widget = widgets.Label(
      css_classes=["window-label", "label-bar"],
      ellipsize="end",
      max_width_chars=40,
      # visible=niri.bind("active_output", lambda output: output == monitor_name),
    )

    menu_widget = widgets.PopoverMenu(
      css_classes=["menu", "menu-fix"],
      model=IgnisMenuModel(
        IgnisMenuItem(
          label="Close",
          on_activate=lambda x: self.niri.active_window.close(),
        ),
        IgnisMenuSeparator(),
        IgnisMenuItem(
          label="Toggle Floating",
          on_activate=lambda x: self.niri.active_window.toggle_floating(),
        ),
        IgnisMenuItem(
          label="Toggle Fullscreen",
          on_activate=lambda x: self.niri.active_window.toggle_fullscreen(),
        ),
      ),
    )

    super().__init__(
      css_classes=["bar-pill", "elevation1"],
      child=[
        widgets.Button(
          css_classes=["pill-button"],
          child=widgets.Box(
            spacing=5,
            child=[
              icon_widget,
              label_widget,
            ],
          ),
          on_click=lambda x: self.menu_widget.popup(),
          on_right_click=lambda x: self.menu_widget.popup(),
        ),
        menu_widget,
      ],
    )

    self.menu_widget = menu_widget
    self.icon_widget = icon_widget
    self.label_widget = label_widget
    self.niri.active_window.connect("notify::title", self.update)
    self.update()

  def update(self, *args):
    if self.niri.is_available:
      self.title = self.niri.active_window.title or DEFAULT_WINDOW_TITLE
      self.app_id = self.niri.active_window.app_id
    elif self.hyprland.is_available:
      self.title = self.hyprland.active_window.title or DEFAULT_WINDOW_TITLE
      self.app_id = self.hyprland.active_window.app_id

    self.menu_widget.popdown()  # Close the menu if the window changed to avoid confusion
    if self.app_id == "":
      self.icon_widget.set_image(DEFAULT_WINDOW_ICON)
    else:
      self.icon_widget.set_image(utils.get_app_icon_name(self.app_id))
    self.label_widget.set_label(self.title)
