from .brightness import MonitorStatusWidget
from .audio import AudioStatusWidget
from .keyboard import keyboard_status
from .power import PowerStatusWidget
from .network import NetworkStatusWidget
from .bluetooth import BluetoothStatusWidget

from .workspaces import workspaces_widget
from .mpris_status import mpris_status_widget
from .window_title import WindowTitleWidget
from .date_time import date_time_widget
from .system_indicators import system_indicators_widget
from .system_status import system_status_widget
from .system_tray import system_tray_widget


all = [
  "MonitorStatusWidget",
  "AudioStatusWidget",
  "keyboard_status",
  "PowerStatusWidget",
  "NetworkStatusWidget",
  "BluetoothStatusWidget",
  "workspaces_widget",
  "mpris_status_widget",
  "WindowTitleWidget",
  "date_time_widget",
  "system_indicators_widget",
  "system_status_widget",
  "system_tray_widget",
]
