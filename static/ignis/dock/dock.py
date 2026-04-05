from ignis import utils, widgets
from ignis.menu_model import IgnisMenuItem, IgnisMenuModel, IgnisMenuSeparator
from ignis.services.hyprland import HyprlandService
from ignis.services.niri import NiriService, NiriWindow, NiriWorkspace
from ignis.window_manager import WindowManager

from user_options import user_options
from utils import get_extended_app_icon, xdg_open


def filtering_function(window: NiriWindow, current_workspace_id: int):
  filter_current_workspace = user_options.dock.filter_current_workspace
  return not filter_current_workspace or window.workspace_id == current_workspace_id


def sorting_function(window: NiriWindow):
  sort_floating_last = user_options.dock.sort_floating_last

  dock_floating_position = window.id + 1000 if sort_floating_last else -1000

  dock_position = (window.workspace_id or 0) * 100 + (
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
  def __init__(
    self,
    image,
    tooltip_text,
    show_dot=False,
    on_click=None,
    on_right_click=None,
  ):
    super().__init__(
      css_classes=["dock-button"],
      child=widgets.Overlay(
        child=widgets.Icon(
          image=image,
          pixel_size=64,
        ),
        overlays=[
          widgets.Box(
            valign="start",
            halign="center",
            css_classes=["running-indicator" if show_dot else None],
          ),
        ],
      ),
      tooltip_text=tooltip_text,  # TODO: Tooltip is not the beest
      on_click=on_click,
      on_right_click=on_right_click,
    )


class DockWindowItem(DockItem):
  def __init__(self, window: NiriWindow):
    app_id = window.app_id
    image = get_extended_app_icon(app_id)
    tooltip_text = window.title
    on_click = lambda _: window.focus()
    # on_right_click = self._popup_menu_and_block_autohide()
    show_dot = window.is_focused
    menu_widget = widgets.PopoverMenu(
      css_classes=["menu"],
      model=IgnisMenuModel(
        IgnisMenuItem(
          label="Close",
          on_activate=lambda _: window.close(),
        ),
        IgnisMenuItem(
          label="Focus",
          on_activate=lambda _: window.focus(),
        ),
        IgnisMenuSeparator(),
        IgnisMenuItem(
          label="Toggle Floating",
          on_activate=lambda _: window.toggle_floating(),
        ),
        IgnisMenuItem(
          label="Toggle Fullscreen",
          on_activate=lambda _: window.toggle_fullscreen(),
        ),
      ),
    )
    super().__init__(
      image=image, tooltip_text=tooltip_text, show_dot=show_dot, on_click=on_click
    )


# class DockAppButton


class DockFolderItem(DockItem):
  def __init__(self, folder_dict):
    image = folder_dict["icon"]
    tooltip_text = folder_dict["name"]
    on_click = lambda _: xdg_open(folder_dict["path"])

    # on_right_click = self._popup_menu_and_block_autohide()
    show_dot = False
    super().__init__(
      image=image, tooltip_text=tooltip_text, show_dot=show_dot, on_click=on_click
    )


class DockSeparator(widgets.Box):
  def __init__(self):
    super().__init__(css_classes=["separator"])


class Dock(widgets.RevealerWindow):
  def __init__(self, monitor_id: int):
    self.monitor_id = 0
    self.timeout = False
    self._has_popup = False

    self.hyprland = HyprlandService.get_default()
    self.niri = NiriService.get_default()
    # self.workspace_id = niri;
    niri_windows = self.niri.bind_many(
      ["windows", "workspaces"],
      lambda windows, workspaces: [
        DockWindowItem(x)
        for x in sort_niri_windows(windows, find_active_niri_workspace_id(workspaces))
      ],
    )

    dock_sections = [
      widgets.Box(spacing=21, child=niri_windows),
    ]

    if user_options.dock.show_folders:
      folders = [
        {
          "icon": "folder-home",
          "path": "~",
          "name": "Home",
        },
        {
          "icon": "folder-downloads",
          "path": "~/Downloads",
          "name": "Downloads",
        },
        {
          "icon": "folder-code",
          "path": "~/Projects",
          "name": "Projects",
        },
      ]

      folder_dock = [DockFolderItem(x) for x in folders]
      dock_sections.append(DockSeparator())
      dock_sections.append(widgets.Box(spacing=21, child=folder_dock))

    revealer = widgets.Revealer(
      transition_type="slide_up",
      child=widgets.Box(
        css_classes=["dock", "elevation4"],
        spacing=16,
        child=dock_sections,
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
      monitor=monitor_id,
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
      height_request=2,
    )

    super().__init__(
      namespace=f"eggshell_dock_trigger_{monitor_id}",
      css_classes=["unset-window"],
      layer="top",
      anchor=["left", "bottom", "right"],
      child=event_box,
      monitor=monitor_id,
    )

  def on_hover_handler(self, *args):
    self.window_manager.get_window(f"eggshell_dock_{self.monitor_id}").show_dock()

  def on_hover_lost_handler(self, *args):
    self.window_manager.get_window(f"eggshell_dock_{self.monitor_id}").timeout_dock()
