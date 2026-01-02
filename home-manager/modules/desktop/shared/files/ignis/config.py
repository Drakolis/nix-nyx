import os

from ignis import utils
from ignis.css_manager import CssInfoPath, CssManager

from bar import Bar
from osd import OSD
from dock import Dock, DockTrigger
from launcher import LauncherTouch

css_manager = CssManager.get_default()

css_manager.apply_css(
  CssInfoPath(
    name="main",
    compiler_function=lambda path: utils.sass_compile(path=path),
    path=os.path.join(utils.get_current_dir(), "scss/style.scss"),
    priority="user",
  )
)

# this will display bar on all monitors
for i in range(utils.get_n_monitors()):
  Bar(i)
  # Notifications
  OSD(i)
  Dock(i)
  DockTrigger(i)

  # SessionMenuWindow
  # LauncherWindow().widget(i)
  LauncherTouch(i)
  # CalendarCenter?Window
  # NotificationCenterWindow
  # ControlCenterWindow(i)
