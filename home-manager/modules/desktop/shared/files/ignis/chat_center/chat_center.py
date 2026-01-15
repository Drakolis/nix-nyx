import asyncio
import os

from gi.repository import Gtk  # type: ignore
from ignis import widgets
from ignis import utils
from user_options import user_options


class ChatCenter(widgets.RevealerWindow):
  def __init__(self, monitor_id: int):
    self.monitor_id = 0
    self.notepad_file_path = user_options.chat_center.notepad_file

    if not os.path.exists(self.notepad_file_path):
      os.mknod(self.notepad_file_path)

    file_contents = utils.read_file(path=self.notepad_file_path)

    self.text_buffer = Gtk.TextBuffer(
      text=file_contents,
    )

    self.text_view = Gtk.TextView(
      css_classes=["input"],
      vexpand=True,
      hexpand=True,
      buffer=self.text_buffer,
    )

    self.text_buffer.connect("changed", self.__on_text_change)

    revealer = widgets.Revealer(
      transition_type="slide_right",
      child=widgets.Box(
        css_classes=["flyout-left", "elevation3"],
        spacing=12,
        width_request=500,
        vexpand=True,
        vertical=True,
        child=[
          widgets.Label(
            label="Notepad",
            css_classes=["title-medium"],
            valign="start",
            halign="start",
          ),
          self.text_view,
        ],
      ),
      transition_duration=300,
      reveal_child=True,
      hexpand=True,
    )

    container = widgets.EventBox(
      child=[revealer],
    )

    super().__init__(
      namespace=f"eggshell_chat_center_{monitor_id}",
      visible=False,
      layer="top",
      anchor=["left", "top", "bottom"],
      child=container,
      revealer=revealer,
      kb_mode="on_demand",
      popup=True,
      setup=lambda self: self.connect(
        "notify::visible", self.__on_open
      ),  # TODO: to improve the way this focuses this may be a separate function
    )
    self.container = container
    self.revealer = revealer

  def __on_open(self, *args):
    self.text_view.grab_focus()

  @utils.debounce(5000)
  def __on_text_change(self, *args):
    asyncio.create_task(
      utils.write_file_async(
        path=self.notepad_file_path,
        string=self.text_buffer.get_text(*self.text_buffer.get_bounds(), True),
      )
    )
