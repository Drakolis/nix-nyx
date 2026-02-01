from .applications import LauncherModeApplications
from .niri_windows import LauncherModeNiriWindows
from .kill import LauncherModePKill
from .currency import LauncherModeCurrency
from .web_search import LauncherModeWebSearch


class LauncherModesManager:
  def __init__(self):
    self.modes = []
    self.default_mode = None
    self.mode_triggers = []

  def register_modes(self):
    applications_mode = LauncherModeApplications()
    self.modes.append(applications_mode)
    self.modes.append(LauncherModeNiriWindows())
    self.modes.append(LauncherModePKill())
    self.modes.append(LauncherModeCurrency())
    self.modes.append(LauncherModeWebSearch())
    # self.modes.append()
    # self.modes.append()
    # self.modes.append()
    self.default_mode = applications_mode
    self.mode_triggers = [f"{mode.trigger} " for mode in self.modes]

  def get_mode_by_trigger(self, query):
    mode_id = self.mode_triggers.index(query)
    return self.modes[mode_id]
