import os
import datetime
import re
from types import LambdaType

from ignis import widgets
from ignis import utils
from ignis.menu_model import IgnisMenuModel, IgnisMenuItem, IgnisMenuSeparator
from ignis.css_manager import CssInfoPath, CssManager
from ignis.services.hyprland import HyprlandService, HyprlandWorkspace
from ignis.services.niri import NiriService, NiriWorkspace
from ignis.services.notifications import NotificationService
from ignis.services.mpris import MprisService, MprisPlayer
from ignis.window_manager import WindowManager
from ignis.services.applications import ApplicationsService

from osd import OSD
from dock import Dock, DockTrigger

from bar.widgets import (
    status_tray,
    system_tray,
)

window_manager = WindowManager.get_default()
css_manager = CssManager.get_default()

css_manager.apply_css(
    CssInfoPath(
        name="main",
        compiler_function=lambda path: utils.sass_compile(path=path),
        path=os.path.join(utils.get_current_dir(), "scss/style.scss"),
        priority="user",
    )
)

hyprland = HyprlandService.get_default()
niri = NiriService.get_default()
notifications = NotificationService.get_default()
mpris = MprisService.get_default()
applications = ApplicationsService.get_default()


def clock() -> widgets.Box:
    # poll for current time every second
    return widgets.Box(
        css_classes=["bar-pill"],
        spacing=2,
        child=[
            widgets.Icon(
                css_classes=["clock-label"],
                image="clock-applet-symbolic",
                pixel_size=16,
            ),
            widgets.Label(
                css_classes=["clock-label"],
                label=utils.Poll(
                    1_000,
                    lambda self: datetime.datetime.now().strftime("%H:%M:%S, %a %d.%b"),
                ).bind("output"),
            ),
        ],
    )


def control_center_button(monitor_id: int) -> widgets.Box:
    return widgets.Box(
        css_classes=["bar-pill"],
        child=[
            widgets.Button(
                on_click=lambda x: window_manager.get_window(
                    f"eggshell_control_center_{monitor_id}"
                ).open_window(),
                child=widgets.Icon(
                    css_classes=["window-label"],
                    image="applications-system-symbolic",
                    pixel_size=16,
                ),
            )
        ],
    )


def hyprland_workspace_button(workspace: HyprlandWorkspace) -> widgets.Button:
    widget = widgets.Button(
        css_classes=["workspace-button"],
        on_click=lambda x: workspace.switch_to(),
        child=widgets.Label(label=str(workspace.id)),
    )
    if workspace.id == hyprland.active_workspace.id:
        widget.add_css_class("active")

    return widget


def niri_workspace_button(workspace: NiriWorkspace) -> widgets.Button:
    widget = widgets.Button(
        css_classes=["workspace-button"],
        on_click=lambda x: workspace.switch_to(),
        child=widgets.Label(label=str(workspace.idx)),
    )
    if workspace.is_active:
        widget.add_css_class("active")

    return widget


def workspace_button(workspace) -> widgets.Button:
    if hyprland.is_available:
        return hyprland_workspace_button(workspace)
    elif niri.is_available:
        return niri_workspace_button(workspace)
    else:
        return widgets.Button()


def hyprland_scroll_workspaces(direction: str) -> None:
    current = hyprland.active_workspace["id"]
    if direction == "up":
        target = current - 1
        hyprland.switch_to_workspace(target)
    else:
        target = current + 1
        if target == 11:
            return
        hyprland.switch_to_workspace(target)


def niri_scroll_workspaces(monitor_name: str, direction: str) -> None:
    current = list(
        filter(lambda w: w.is_active and w.output == monitor_name, niri.workspaces)
    )[0].idx
    if direction == "up":
        target = current + 1
        niri.switch_to_workspace(target)
    else:
        target = current - 1
        niri.switch_to_workspace(target)


def scroll_workspaces(direction: str, monitor_name: str = "") -> None:
    if hyprland.is_available:
        hyprland_scroll_workspaces(direction)
    elif niri.is_available:
        niri_scroll_workspaces(monitor_name, direction)
    else:
        pass


def hyprland_workspaces() -> widgets.EventBox:
    return widgets.EventBox(
        on_scroll_up=lambda x: scroll_workspaces("up"),
        on_scroll_down=lambda x: scroll_workspaces("down"),
        css_classes=["bar-pill"],
        spacing=5,
        child=hyprland.bind_many(  # bind also to active_workspace to regenerate workspaces list when active workspace changes
            ["workspaces", "active_workspace"],
            transform=lambda workspaces, active_workspace: [
                workspace_button(i) for i in workspaces
            ],
        ),
    )


def niri_workspaces(monitor_name: str) -> widgets.EventBox:
    return widgets.EventBox(
        on_scroll_up=lambda x: scroll_workspaces("up", monitor_name),
        on_scroll_down=lambda x: scroll_workspaces("down", monitor_name),
        css_classes=["bar-pill"],
        spacing=5,
        child=niri.bind(
            "workspaces",
            transform=lambda value: [
                workspace_button(i) for i in value if i.output == monitor_name
            ],
        ),
    )


def workspaces(monitor_id: int) -> widgets.EventBox:
    monitor_name = utils.get_monitor(monitor_id).get_connector()

    if hyprland.is_available:
        return hyprland_workspaces()
    elif niri.is_available:
        return niri_workspaces(monitor_name)
    else:
        return widgets.EventBox()


DEFAULT_WINDOW_TITLE = "NixOS"
DEFAULT_WINDOW_ICON = "distributor-logo-nixos"


class WindowTitle:
    def __init__(self):
        self.title = DEFAULT_WINDOW_TITLE
        self.app_id = ""

        self.icon_widget = widgets.Icon(
            css_classes=["window-icon"],
            pixel_size=16,
        )

        self.label_widget = widgets.Label(
            css_classes=["window-label"],
            ellipsize="end",
            max_width_chars=40,
            # visible=niri.bind("active_output", lambda output: output == monitor_name),
        )

        self.menu_widget = widgets.PopoverMenu(
            css_classes=["menu", "menu-fix"],
            model=IgnisMenuModel(
                IgnisMenuItem(
                    label="Close",
                    on_activate=lambda x: niri.active_window.close(),
                ),
                IgnisMenuSeparator(),
                IgnisMenuItem(
                    label="Toggle Floating",
                    on_activate=lambda x: niri.active_window.toggle_floating(),
                ),
                IgnisMenuItem(
                    label="Toggle Fullscreen",
                    on_activate=lambda x: niri.active_window.toggle_fullscreen(),
                ),
            ),
        )

        niri.active_window.connect("notify::title", self.update)
        self.update()

    def update(self, *args):
        if niri.is_available:
            self.title = niri.active_window.title or DEFAULT_WINDOW_TITLE
            self.app_id = niri.active_window.app_id
        elif hyprland.is_available:
            self.title = hyprland.active_window.title or DEFAULT_WINDOW_TITLE
            self.app_id = hyprland.active_window.app_id
        print(self.title)
        print(self.app_id)
        self.menu_widget.popdown()  # Close the menu if the window changed to avoid confusion
        if self.app_id == "":
            self.icon_widget.set_image(DEFAULT_WINDOW_ICON)
        else:
            self.icon_widget.set_image(utils.get_app_icon_name(self.app_id))
        self.label_widget.set_label(self.title)

    def widget(self, monitor_id):
        return widgets.Box(
            child=[
                widgets.EventBox(
                    spacing=5,
                    css_classes=["bar-pill"],
                    child=[
                        self.icon_widget,
                        self.label_widget,
                    ],
                    on_click=lambda x: self.menu_widget.popup(),
                    on_right_click=lambda x: self.menu_widget.popup(),
                ),
                self.menu_widget,
            ]
        )


class Bar(widgets.Window):
    def __init__(self, monitor_id):
        self.monitor_id = monitor_id

        super().__init__(
            namespace=f"eggshell_bar_{monitor_id}",
            monitor=monitor_id,
            anchor=["left", "top", "right"],
            exclusivity="exclusive",
            child=widgets.CenterBox(
                css_classes=["bar-container"],
                start_widget=widgets.Box(
                    child=[workspaces(monitor_id), WindowTitle().widget(monitor_id)]
                ),
                center_widget=clock(),
                end_widget=widgets.Box(
                    child=[
                        status_tray(),
                        system_tray(),
                        control_center_button(monitor_id),
                    ]
                ),
            ),
        )


def map_applications_to_action_list(app):
    return {
        "title": app.name,
        "description": app.description,
        "icon-name": app.icon,
        "action": lambda x: app.launch(terminal_format="kitty %command%"),
    }


class ControlCenterWindow(widgets.RevealerWindow):
    def __init__(self, monitor_id: int):
        self.monitor_id = monitor_id
        self.timeout = False

        revealer = widgets.Revealer(
            transition_type="slide_down",
            child=widgets.Box(
                css_classes=["popup", "elevation1"],
                child=[
                    widgets.Box(
                        css_classes=["control"],
                        child=[widgets.Label(label="Control Center")],
                    )
                ],
                vertical=True,
                hexpand=True,
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
            visible=False,
            popup=True,
            kb_mode="on_demand",
            layer="top",
            anchor=["right", "top"],
            namespace=f"eggshell_control_center_{monitor_id}",
            revealer=revealer,
            child=container,
        )

    def on_hover_lost_handler(self, *args):
        self.timeout = utils.Timeout(ms=750, target=lambda: self.close_window())

    def on_hover_handler(self, *args):
        if self.timeout:
            self.timeout.cancel()
            self.timeout = False

    def open_window(self):
        self.set_visible(True)
        self.timeout = utils.Timeout(ms=2000, target=lambda: self.close_window())

    def close_window(self):
        if self.timeout:
            self.timeout.cancel()
            self.timeout = False
        self.set_visible(False)


class LauncherWindow:
    def __init__(self):
        self.monitor_id = 0

        # title,
        # description?,
        # icon,
        # action
        self.applications = applications.apps
        self.action_list = [
            map_applications_to_action_list(a) for a in self.applications
        ]
        self.always_shown = []

        self.window = widgets.Window(
            namespace=f"eggshell_launcher_{self.monitor_id}",
            anchor=["bottom"],  # DELETE ME
            monitor=self.monitor_id,
            kb_mode="on_demand",
            child=widgets.Box(
                css_classes=["launcher-container", "has-outline", "has-shadow"],
                child=[
                    widgets.Box(
                        hexpand=True,
                        vertical=True,
                        child=[
                            widgets.Box(
                                hexpand=True,
                                css_classes=["launcher-input"],
                                spacing=5,
                                child=[
                                    widgets.Icon(image="search", pixel_size=16),
                                    widgets.Entry(
                                        vexpand=True,
                                        hexpand=True,
                                        placeholder_text="Search...",
                                        on_accept=lambda x: print(x.text),
                                        on_change=lambda x: print(x.text),
                                    ),
                                ],
                            ),
                            widgets.Scroll(
                                child=widgets.Box(
                                    vertical=True,
                                    child=[
                                        self.launcher_item(action_item)
                                        for action_item in self.action_list
                                    ],
                                ),
                                height_request=250,
                            ),
                            widgets.Box(
                                hexpand=True,
                                css_classes=["launcher-footer"],
                                spacing=5,
                                child=[
                                    widgets.Button(
                                        on_click=lambda x: self.launch_app(),
                                        child=widgets.Icon(
                                            image="settings", pixel_size=16
                                        ),
                                    ),
                                ],
                            ),
                        ],
                    )
                ],
            ),
        )

    def launcher_item(self, action_item):
        return widgets.Button(
            css_classes=["launcher-item"],
            child=widgets.Box(
                hexpand=True,
                child=[
                    widgets.Icon(image=action_item["icon-name"], pixel_size=52),
                    widgets.Box(
                        css_classes=["launcher-item-label"],
                        vertical=True,
                        vexpand=True,
                        valign="center",
                        child=[
                            widgets.Label(
                                css_classes=["launcher-item-label-title"],
                                halign="start",
                                hexpand=True,
                                justify="left",
                                label=action_item["title"],
                            ),
                            (
                                widgets.Label(
                                    css_classes=["launcher-item-label-description"],
                                    halign="start",
                                    hexpand=True,
                                    justify="left",
                                    label=action_item["description"],
                                )
                                if action_item["description"]
                                else None
                            ),
                        ],
                    ),
                ],
            ),
        )

    def widget(self, monitor_id: int):
        self.monitor_id = monitor_id
        return self.window


# this will display bar on all monitors
for i in range(utils.get_n_monitors()):
    this_bar = Bar(i)
    # Notifications
    OSD(i)
    Dock(i)
    DockTrigger(i)

    # SessionMenuWindow
    # LauncherWindow().widget(i)
    # CalendarCenter?Window
    # NotificationCenterWindow
    this_control_center = ControlCenterWindow(i)
