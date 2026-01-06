import math
from pty import spawn

from ignis import widgets

from ignis.services.upower import UPowerService

# TODO: Subscribe OSD for power/battery connected/switch events

CSS_CLASS_CRITICAL = "power-critical-label"
CSS_CLASS_WARNING = "power-warning-label"
CSS_CLASS_NORMAL = "power-normal-label"
CSS_CLASS_AC = "power-label"
DEFAULT_LABEL = "PWR"
DEFAULT_ICON = "battery-ac-adapter-symbolic"


class PowerStatusWidget(widgets.Button):
  def __init__(self):
    self.upower = UPowerService.get_default()

    power_status_label = [
      widgets.Icon(
        css_classes=[CSS_CLASS_AC],
        image=DEFAULT_ICON,
        pixel_size=16,
      ),
      widgets.Label(
        css_classes=[CSS_CLASS_AC, "label-bar"],
        label=DEFAULT_LABEL,
      ),
    ]

    super().__init__(
      css_classes=["pill-button"],
      on_right_click=lambda self: True,
      child=widgets.Box(child=power_status_label, spacing=5),
    )

    self.power_status_label = power_status_label

    if self.upower.display_device.kind == "battery":
      self.upower.display_device.connect(
        "notify::percent", lambda x, y: self.update_battery_status(x)
      )
      self.upower.display_device.connect(
        "notify::charging", lambda x, y: self.update_battery_status(x)
      )
      self.update_battery_status(self.upower.display_device)

  def update_battery_status(self, display_device):
    battery_percentage = math.floor(display_device.percent)

    if battery_percentage < 20:
      icon = f"battery-020{'-charging' if display_device.charging else ''}-symbolic"
      css_class = CSS_CLASS_CRITICAL
    elif battery_percentage < 40:
      icon = f"battery-040{'-charging' if display_device.charging else ''}-symbolic"
      css_class = CSS_CLASS_WARNING
    elif battery_percentage < 60:
      icon = f"battery-060{'-charging' if display_device.charging else ''}-symbolic"
      css_class = CSS_CLASS_WARNING
    elif battery_percentage < 80:
      icon = f"battery-080{'-charging' if display_device.charging else ''}-symbolic"
      css_class = CSS_CLASS_NORMAL
    elif battery_percentage < 90:
      icon = f"battery-090{'-charging' if display_device.charging else ''}-symbolic"
      css_class = CSS_CLASS_NORMAL
    elif battery_percentage < 100:
      icon = f"battery-100{'-charging' if display_device.charging else ''}-symbolic"
      css_class = CSS_CLASS_NORMAL
    else:
      icon = f"battery-100{'-charging' if display_device.charging else ''}-symbolic"
      css_class = CSS_CLASS_NORMAL

    if display_device.charging:
      css_classes = CSS_CLASS_NORMAL

    self.power_status_label[0].image = icon
    self.power_status_label[0].css_classes = [css_class]
    self.power_status_label[1].label = f"{battery_percentage}%"
    self.power_status_label[1].css_classes = [css_class, "label-bar"]
