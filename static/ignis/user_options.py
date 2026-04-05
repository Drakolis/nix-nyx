import os

from ignis import DATA_DIR  # type: ignore
from ignis.options_manager import OptionsGroup, OptionsManager

USER_OPTIONS_FILE = f"{DATA_DIR}/user_options.json"

DEFAULT_NOTEPAD_FILE = f"{DATA_DIR}/notepad"


class UserOptions(OptionsManager):
  def __init__(self):
    try:
      super().__init__(file=USER_OPTIONS_FILE)
    except FileNotFoundError:
      pass

  class ChatCenter(OptionsGroup):
    notepad_file: str = DEFAULT_NOTEPAD_FILE

  class Dock(OptionsGroup):
    enable: bool = True
    always_shown: bool = False
    cover_windows: bool = True

    show_bin: bool = True
    show_launcher: bool = True

    show_folders: bool = True  # Done
    # Niri Specific
    filter_current_workspace: bool = False  # Done
    sort_floating_last: bool = True  # Done

    # Group Windows?

  class User(OptionsGroup):
    avatar: str = f"/var/lib/AccountsService/icons/{os.getenv('USER')}"

  chat_center = ChatCenter()
  dock = Dock()
  user = User()


user_options = UserOptions()
