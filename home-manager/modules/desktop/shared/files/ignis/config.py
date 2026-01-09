import os

from ignis import utils
from ignis.css_manager import CssInfoPath, CssManager

from bar import Bar
from osd import OSD
from dock import Dock, DockTrigger
from launcher import LauncherWindow
from notifications import NotificationPopup
from session import SessionMenu

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
for monitor in range(utils.get_n_monitors()):
  Bar(monitor)
  OSD(monitor)
  Dock(monitor)
  DockTrigger(monitor)
  NotificationPopup(monitor)

  SessionMenu(monitor)

LauncherWindow()
# LauncherTouch(monitor)

# ControlCenterWindow(i)
