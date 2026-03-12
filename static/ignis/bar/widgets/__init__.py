from .audio import AudioStatusWidget
from .bluetooth import BluetoothStatusWidget
from .brightness import MonitorStatusWidget
from .chat_center_button import chat_center_button_widget
from .control_center_button import control_center_button_widget
from .date_time import date_time_widget
from .keyboard import keyboard_status
from .mpris_status import mpris_status_widget
from .network import NetworkStatusWidget
from .power import PowerStatusWidget
from .system_indicators import system_indicators_widget
from .system_status import system_status_widget
from .system_tray import system_tray_widget
from .window_title import WindowTitleWidget
from .workspaces import workspaces_widget

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
