from ignis import widgets
from ignis.window_manager import WindowManager

window_manager = WindowManager.get_default()


def chat_center_button_widget() -> widgets.Box:
  # poll for current time every second
  return widgets.Box(
    css_classes=["bar-pill", "elevation1"],
    child=[
      widgets.Button(
        on_click=lambda x: window_manager.toggle_window("eggshell_chat_center"),
        css_classes=["pill-button"],
        child=widgets.Box(
          spacing=3,
          child=[
            widgets.Icon(
              css_classes=["primary-label"],
              image="system-user-prompt-symbolic",
              pixel_size=24,
              hexpand=True,
            ),
          ],
        ),
      )
    ],
  )
