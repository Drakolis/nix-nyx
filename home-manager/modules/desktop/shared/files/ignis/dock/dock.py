from ignis import widgets
from ignis import utils

from ignis.menu_model import IgnisMenuModel, IgnisMenuItem, IgnisMenuSeparator

from ignis.services.hyprland import HyprlandService, HyprlandWorkspace
from ignis.services.niri import NiriService, NiriWindow, NiriWindowLayout, NiriWorkspace

from ignis.window_manager import WindowManager

from utils import get_extended_app_icon

from user_options import user_options


def filtering_function(window: NiriWindow, current_workspace_id: int):
  filter_current_workspace = user_options.dock.filter_current_workspace
  return not filter_current_workspace or window.workspace_id == current_workspace_id


def sorting_function(window: NiriWindow):
  sort_floating_last = user_options.dock.sort_floating_last

  dock_floating_position = window.id + 1000 if sort_floating_last else -1000

  dock_position = window.workspace_id * 100 + (
    window.layout.pos_in_scrolling_layout[0]
    if window.layout.pos_in_scrolling_layout
    else dock_floating_position
  )

  return dock_position


def sort_niri_windows(windows: [NiriWindow], current_workspace_id: int):
  return sorted(
    [w for w in windows if filtering_function(w, current_workspace_id)],
    key=sorting_function,
  )


def find_active_niri_workspace_id(workspaces: [NiriWorkspace]):
  return [ws.id for ws in workspaces if ws.is_active][0]


class DockItem(widgets.Button):
  def __init__(self, window: NiriWindow):
    app_id = window.app_id

    menu_widget = widgets.PopoverMenu(
      css_classes=["menu"],
      model=IgnisMenuModel(
        IgnisMenuItem(
          label="Close",
          on_activate=lambda x: window.close(),
        ),
        IgnisMenuItem(
          label="Focus",
          on_activate=lambda x: window.focus(),
        ),
        IgnisMenuSeparator(),
        IgnisMenuItem(
          label="Toggle Floating",
          on_activate=lambda x: window.toggle_floating(),
        ),
        IgnisMenuItem(
          label="Toggle Fullscreen",
          on_activate=lambda x: window.toggle_fullscreen(),
        ),
      ),
    )

    super().__init__(
      css_classes=["app-icon-button"],
      child=widgets.Overlay(
        child=widgets.Icon(
          image=(get_extended_app_icon(app_id)),
          pixel_size=64,
        ),
        overlays=[
          widgets.Box(
            valign="start",
            halign="center",
            css_classes=["running-indicator" if window.is_focused else None],
          ),
          menu_widget,
        ],
      ),
      tooltip_text=window.title,  # TODO: Tooltip is not the beest
      on_click=lambda x: window.focus(),
      on_right_click=lambda x: self._popup_menu_and_block_autohide(),
    )

    self.window = window
    self.menu_widget = menu_widget

  def _popup_menu_and_block_autohide(self, *args):
    self.menu_widget.popup()


class Dock(widgets.RevealerWindow):
  def __init__(self, monitor_id: int):
    self.monitor_id = 0
    self.timeout = False
    self._has_popup = False

    self.hyprland = HyprlandService.get_default()
    self.niri = NiriService.get_default()
    # self.workspace_id = niri;
    dock_items = self.niri.bind_many(
      ["windows", "workspaces"],
      lambda windows, workspaces: [
        DockItem(x)
        for x in sort_niri_windows(windows, find_active_niri_workspace_id(workspaces))
      ],
    )

    self.current_applications = []

    revealer = widgets.Revealer(
      transition_type="slide_up",
      child=widgets.Box(
        css_classes=["dock", "elevation3"],
        spacing=24,
        child=dock_items,
      ),
      transition_duration=300,
      reveal_child=True,
      hexpand=True,
    )

    container = widgets.EventBox(
      child=[revealer],
      on_hover=self.on_hover_handler,
      on_hover_lost=self.on_hover_lost_handler,
    )

    super().__init__(
      namespace=f"eggshell_dock_{monitor_id}",
      css_classes=["unset-window"],
      visible=False,
      layer="top",
      anchor=["bottom"],
      child=container,
      revealer=revealer,
      # kb_mode="on_demand",  # TODO: Keyboard navigation
      popup=True,
    )
    self.container = container
    self.revealer = revealer

  def show_dock(self):
    self.stop_timeout_dock()
    self.set_visible(True)

  def hide_dock(self):
    self.stop_timeout_dock()
    self.set_visible(False)

  def timeout_dock(self):
    self.timeout = utils.Timeout(ms=1000, target=lambda: self.hide_dock())

  def stop_timeout_dock(self):
    if self.timeout:
      self.timeout.cancel()
      self.timeout = False

  def on_hover_handler(self, *args):
    self.stop_timeout_dock()
    self.show_dock()

  def on_hover_lost_handler(self, *args):
    if not self._has_popup:
      self.timeout_dock()


class DockTrigger(widgets.Window):
  def __init__(self, monitor_id: int):
    self.monitor_id = monitor_id
    self.window_manager = WindowManager.get_default()
    event_box = widgets.EventBox(
      css_classes=["dock-trigger"],
      on_hover=self.on_hover_handler,
      on_hover_lost=self.on_hover_lost_handler,
      height_request=10,
    )

    super().__init__(
      namespace=f"eggshell_dock_trigger_{monitor_id}",
      css_classes=["unset-window"],
      layer="top",
      anchor=["left", "bottom", "right"],
      child=event_box,
    )

  def on_hover_handler(self, *args):
    self.window_manager.get_window(f"eggshell_dock_{self.monitor_id}").show_dock()

  def on_hover_lost_handler(self, *args):
    self.window_manager.get_window(f"eggshell_dock_{self.monitor_id}").timeout_dock()
