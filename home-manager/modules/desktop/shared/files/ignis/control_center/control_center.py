import asyncio

from ignis import widgets
from ignis import utils
from user_options import user_options


class ControlCenter(widgets.RevealerWindow):
  def __init__(self, monitor_id: int):
    self.monitor_id = 0

    revealer = widgets.Revealer(
      transition_type="slide_left",
      child=widgets.Box(
        css_classes=["flyout-right", "elevation3"],
        spacing=12,
        width_request=500,
        vexpand=True,
        vertical=True,
        child=[
          widgets.Label(
            label="Control Center",
            css_classes=["title-medium"],
            valign="start",
            halign="start",
          ),
          widgets.Box(
            css_classes=["section"],
            hexpand=True,
            homogeneous=True,
            child=[
              widgets.Button(
                child=widgets.Icon(image="system-shutdown-symbolic", pixel_size=48),
                on_click=lambda x: asyncio.create_task(
                  utils.exec_sh_async("systemctl poweroff")
                ),
                css_classes=["button-fab-power-off"],
                halign="center",
              ),
              widgets.Button(
                child=widgets.Icon(image="system-suspend-symbolic", pixel_size=48),
                on_click=lambda x: asyncio.create_task(
                  utils.exec_sh_async("systemctl suspend")
                ),
                css_classes=["button-fab-sleep"],
                halign="center",
              ),
              # widgets.Button(
              #   child=widgets.Icon(
              #     image="system-suspend-hibernate-symbolic", pixel_size=48
              #   ),
              #   on_click=lambda x: asyncio.create_task(
              #     utils.exec_sh_async("systemctl hibernate")
              #   ),
              #   css_classes=["button-fab-hibernate"],
              #   halign="center",
              # ),
              widgets.Button(
                child=widgets.Icon(image="system-restart-symbolic", pixel_size=48),
                on_click=lambda x: asyncio.create_task(
                  utils.exec_sh_async("systemctl reboot")
                ),
                css_classes=["button-fab-restart"],
                halign="center",
              ),
              widgets.Button(
                child=widgets.Icon(image="system-log-out-symbolic", pixel_size=48),
                on_click=lambda x: asyncio.create_task(
                  utils.exec_sh_async("loginctl terminate-user $USER")
                ),
                css_classes=["button-fab-log-out"],
                halign="center",
              ),
            ],
          ),
        ],
      ),
      transition_duration=300,
      reveal_child=True,
      hexpand=True,
    )

    container = widgets.EventBox(
      child=[revealer],
    )

    super().__init__(
      namespace=f"eggshell_control_center_{monitor_id}",
      css_classes=["unset-window"],
      visible=False,
      layer="top",
      anchor=["right", "top", "bottom"],
      child=container,
      revealer=revealer,
      kb_mode="on_demand",
      popup=True,
      # setup=lambda self: self.connect(
      #   "notify::visible", self.__on_open
      # ),  # TODO: to improve the way this focuses this may be a separate function
    )
    self.container = container
    self.revealer = revealer
