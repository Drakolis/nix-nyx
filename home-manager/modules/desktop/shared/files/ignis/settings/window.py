import asyncio
import os

from gi.repository import Gtk  # type: ignore
from ignis import widgets
from ignis import utils
from user_options import user_options


class SettingsWindow(widgets.RegularWindow):
  def __init__(self):
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
      title="This is title",
      titlebar=widgets.HeaderBar(show_title_buttons=True),
      namespace="eggshell_settings",
      visible=False,
      child=section_dock,
      # setup=lambda self: self.connect(
      #   "notify::visible", self.__on_open
      # ),  # TODO: to improve the way this focuses this may be a separate function
    )
    self.section_dock = section_dock
