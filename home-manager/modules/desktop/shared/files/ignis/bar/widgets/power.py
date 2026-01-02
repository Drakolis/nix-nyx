import math

from ignis import widgets

from ignis.services.upower import UPowerService

upower = UPowerService.get_default()

# TODO: Subscribe OSD for power/battery connected/switch events

css_class_critical = "power-critical-label"
css_class_warning = "power-warning-label"
css_class_normal = "power-normal-label"

def power_render_contents(display_device):
  label = "PWR"
  icon = "battery-ac-adapter-symbolic"
  css_class = "power-label"

  if display_device.kind == "battery":
    label = f"{math.floor(display_device.percent)}%"
    if display_device.percent < 5:
      icon = f"battery-000{'-charging' if display_device.charging else ''}-symbolic"
      css_class = css_class_critical
    elif display_device.percent < 10:
      icon = f"battery-010{'-charging' if display_device.charging else ''}-symbolic"
      css_class = css_class_critical
    elif display_device.percent < 20:
      icon = f"battery-020{'-charging' if display_device.charging else ''}-symbolic"
      css_class = css_class_critical
    elif display_device.percent < 30:
      icon = f"battery-030{'-charging' if display_device.charging else ''}-symbolic"
      css_class = css_class_warning
    elif display_device.percent < 40:
      icon = f"battery-040{'-charging' if display_device.charging else ''}-symbolic"
      css_class = css_class_warning
    elif display_device.percent < 50:
      icon = f"battery-050{'-charging' if display_device.charging else ''}-symbolic"
      css_class = css_class_warning
    elif display_device.percent < 60:
      icon = f"battery-060{'-charging' if display_device.charging else ''}-symbolic"
      css_class = css_class_normal
    elif display_device.percent < 70:
      icon = f"battery-070{'-charging' if display_device.charging else ''}-symbolic"
      css_class = css_class_normal
    elif display_device.percent < 80:
      icon = f"battery-080{'-charging' if display_device.charging else ''}-symbolic"
      css_class = css_class_normal
    elif display_device.percent < 90:
      icon = f"battery-090{'-charging' if display_device.charging else ''}-symbolic"
      css_class = css_class_normal
    elif display_device.percent < 100:
      icon = f"battery-100{'-charging' if display_device.charging else ''}-symbolic"
      css_class = css_class_normal
    else:
      icon = f"battery-100{'-charging' if display_device.charging else ''}-symbolic"
      css_class = css_class_normal

  return [
    widgets.Icon(
      css_classes=[css_class],
      image=icon,
      pixel_size=16,
    ),
    widgets.Label(
      css_classes=[css_class, "label-bar"],
      label=label,
    ),
  ]

def power_status() -> widgets.EventBox:
  on_click_handler = lambda self: True

  network_widgets = upower.bind_many(
    ["display_device"],
    power_render_contents
  )

  return widgets.EventBox(
    on_right_click=on_click_handler,
    spacing=5,
    child=network_widgets,
  )
