import os
from ignis.options_manager import OptionsGroup, OptionsManager
from ignis import DATA_DIR, CACHE_DIR  # type: ignore

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
    filter_current_workspace: bool = False
    sort_floating_last: bool = True

  chat_center = ChatCenter()
  dock = Dock()


user_options = UserOptions()
