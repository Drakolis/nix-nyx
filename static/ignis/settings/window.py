import asyncio
import os

from gi.repository import Gtk  # type: ignore
from ignis import widgets
from ignis import utils
from user_options import user_options


class SettingsWindow(widgets.RegularWindow):
  def __init__(self):
    stack = Gtk.Stack(
    )
    stack.add_child(
        Gtk.StackPage(
          title="page 3", icon_name="", child=widgets.Label(label="welcome to page 3!")
        )
    )
    section_dock = (
      widgets.Box(
        css_classes=["sheet"],
        spacing=12,
        width_request=500,
        vexpand=True,
        vertical=True,
        child=[
          widgets.Label(
            label="Settings",
            css_classes=["title-medium"],
            valign="start",
            halign="start",
          ),
          widgets.Box(
            css_classes=["section"],
            hexpand=True,
            homogeneous=True,
            child=[],
          ),
        ],
      ),
    )

    super().__init__(
      title="Eggshell Settings",
      titlebar=widgets.HeaderBar(show_title_buttons=True),
      namespace="eggshell_settings",
      visible=True,
      child=widgets.Box(
        child=[
          widgets.Box(
            vertical=True,
            # you should add both StackSwitcher and Stack.
            child=[widgets.StackSwitcher(stack=stack), stack],
          )
        ]
      ),
      # setup=lambda self: self.connect(
      #   "notify::visible", self.__on_open
      # ),  # TODO: to improve the way this focuses this may be a separate function
    )
    self.section_dock = section_dock
