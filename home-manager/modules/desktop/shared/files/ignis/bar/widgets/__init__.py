from .brightness import MonitorStatusWidget
from .audio import AudioStatusWidget
from .keyboard import keyboard_status
from .power import PowerStatusWidget
from .network import NetworkStatusWidget
from .bluetooth import BluetoothStatusWidget

from .system_tray import system_tray_widget
from .system_status import system_status_widget
from .system_indicators import system_indicators_widget
from .date_time import date_time_widget
from .workspaces import workspaces_widget
from .window_title import WindowTitleWidget


all = [
  "MonitorStatusWidget",
  "AudioStatusWidget",
  "keyboard_status",
  "PowerStatusWidget",
  "NetworkStatusWidget",
  "BluetoothStatusWidget",
  "system_tray_widget",
  "system_status_widget",
  "system_indicators_widget",
  "date_time_widget",
  "workspaces_widget",
  "WindowTitleWidget",
]
