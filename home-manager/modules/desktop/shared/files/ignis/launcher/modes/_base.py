from ignis.window_manager import WindowManager

window_manager = WindowManager.get_default()


class LauncherActionDefinition:
  def __init__(self, title, icon, action, description=""):
    self.title = title
    self.description = description
    self.icon = icon
    self.raw_action = action

  def action(self, *args):
    self.raw_action()
    window_manager.close_window("eggshell_launcher")


class LauncherModeBase:
  def __init__(self, name, placeholder, trigger, search_function):
    self.name = name
    self.placeholder = placeholder
    self.trigger = trigger
    self.search_function = search_function
