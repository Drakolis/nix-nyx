from ignis import widgets
from ignis.window_manager import WindowManager

window_manager = WindowManager.get_default()


def control_center_button_widget() -> widgets.Box:
  # poll for current time every second
  return widgets.Button(
    on_click=lambda x: window_manager.toggle_window("eggshell_control_center"),
    css_classes=["pill-button"],
    child=widgets.Box(
      spacing=3,
      child=[
        widgets.Icon(
          css_classes=["primary-label"],
          image="system-run-symbolic",
          pixel_size=24,
          hexpand=True,
        ),
      ],
    ),
  )
