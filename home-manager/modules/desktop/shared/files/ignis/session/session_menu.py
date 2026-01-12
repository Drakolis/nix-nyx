
import asyncio

from ignis import widgets
from ignis import utils

class SessionMenu(widgets.RevealerWindow):
  def __init__(self, monitor_id: int):
    self.monitor_id = monitor_id

    revealer = widgets.Revealer(
      transition_type="crossfade",
      transition_duration=300,
      reveal_child=True,
      hexpand=True,
      vexpand=True,
      child=widgets.Box(
        css_classes=["fade"],
        child=[
          widgets.Box(
            halign="center",
            valign="center",
            css_classes=["osd-container", "sheet", "elevation3", "corner-large"],
            hexpand=True,
            child=[
              widgets.Button(
                child=widgets.Icon(image="system-shutdown", pixel_size=64),
                on_click=lambda x: asyncio.create_task(utils.exec_sh_async("systemctl poweroff"))
              ),
              widgets.Button(
                child=widgets.Icon(image="system-suspend", pixel_size=64),
                on_click=lambda x: asyncio.create_task(utils.exec_sh_async("systemctl suspend"))
              ),
              widgets.Button(
                child=widgets.Icon(image="system-suspend-hibernate", pixel_size=64),
                on_click=lambda x: asyncio.create_task(utils.exec_sh_async("systemctl hibernate"))
              ),
              widgets.Button(
                child=widgets.Icon(image="system-restart", pixel_size=64),
                on_click=lambda x: asyncio.create_task(utils.exec_sh_async("systemctl reboot"))
              ),
              widgets.Button(
                child=widgets.Icon(image="system-log-out", pixel_size=64),
                on_click=lambda x: asyncio.create_task(utils.exec_sh_async("loginctl terminate-user $USER"))
              ),
            ]
          ),
        ]
      ),
    )

    container = widgets.EventBox(
      child=[revealer],

      vexpand=True,
      # on_hover=self.on_hover_handler,
      # on_hover_lost=self.on_hover_lost_handler,
    )

    super().__init__(
      namespace=f"eggshell_session_menu_{monitor_id}",
      visible=False,
      layer="top",
      exclusivity="ignore",
      anchor=["bottom", "top", "left", "right"],
      child=container,
      revealer=revealer,
      kb_mode="on_demand",  # TODO: Keyboard navigation
      popup=True,
    )

  # widgets.Button(
  #   child=widgets.Icon(image="system-save-session", pixel_size=32),
  #   on_click=lambda x: asyncio.create_task(utils.exec_sh_async("pavucontrol"))
  # ),
  # widgets.Button(
  #   child=widgets.Icon(image="system-lock-screen", pixel_size=32),
  #   on_click=lambda x: asyncio.create_task(utils.exec_sh_async("pavucontrol"))
  # ),
