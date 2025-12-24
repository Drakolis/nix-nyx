from ignis import widgets
from ignis import utils

from ignis.menu_model import IgnisMenuModel, IgnisMenuItem, IgnisMenuSeparator

from ignis.services.hyprland import HyprlandService, HyprlandWorkspace
from ignis.services.niri import NiriService, NiriWindow

from ignis.window_manager import WindowManager

DEFAULT_WINDOW_ICON = "application-default-icon"


def sort_niri_windows(windows: [NiriWindow]):
    return sorted(
        windows,
        key=lambda window: window.layout.pos_in_scrolling_layout[0],
    )


class DockItem(widgets.Button):
    def __init__(self, window: NiriWindow):
        app_id = window.app_id

        # TODO: Menu widget should somehow prevent the dock from closing
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
                    image=(
                        utils.get_app_icon_name(app_id)
                        if app_id
                        else DEFAULT_WINDOW_ICON
                    ),
                    pixel_size=64,
                ),
                overlays=[
                    widgets.Box(
                        valign="start",
                        halign="center",
                        css_classes=[
                            "running-indicator" if window.is_focused else None
                        ],  # TODO: Indicator for floating
                    )
                ],
            ),
            tooltip_text=window.title,  # TODO: Tooltip is not the beest
            on_click=lambda x: window.focus(),
            on_right_click=lambda x: menu_widget.popup(),
        )

        self.window = window
        self.menu_widget = menu_widget


class Dock(widgets.RevealerWindow):
    def __init__(self, monitor_id: int):
        self.monitor_id = 0
        self.timeout = False

        self.hyprland = HyprlandService.get_default()
        self.niri = NiriService.get_default()
        # self.workspace_id = niri;
        dock_items = self.niri.bind(
            "windows",
            lambda windows: [DockItem(x) for x in sort_niri_windows(windows)],
        )

        self.current_applications = []

        revealer = widgets.Revealer(
            transition_type="slide_up",
            child=widgets.Box(
                css_classes=["dock", "popup"],
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
            layer="top",
            anchor=["left", "bottom", "right"],
            child=event_box,
        )

    def on_hover_handler(self, *args):
        self.window_manager.get_window(f"eggshell_dock_{self.monitor_id}").show_dock()

    def on_hover_lost_handler(self, *args):
        self.window_manager.get_window(
            f"eggshell_dock_{self.monitor_id}"
        ).timeout_dock()
