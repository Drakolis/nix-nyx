import os

from ignis import utils
from ignis.css_manager import CssInfoPath, CssManager
from ignis.window_manager import WindowManager

from bar import Bar
from chat_center import ChatCenter
from control_center import ControlCenter
from dock import Dock, DockTrigger
from info_center import InfoCenter
from launcher import LauncherWindow
from notifications import NotificationPopup
from osd import OSD
from settings import SettingsWindow

css_manager = CssManager.get_default()
window_manager = WindowManager.get_default()

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
  Dock(monitor)
  DockTrigger(monitor)
  NotificationPopup(monitor)
  OSD(monitor)

ChatCenter()
ControlCenter()
InfoCenter()
LauncherWindow()
SettingsWindow()
# LauncherTouch(monitor)
