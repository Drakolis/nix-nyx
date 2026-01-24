import socket
import asyncio
import os
import pwd

from ignis import widgets
from ignis import utils
from ignis.window_manager import WindowManager
from ignis.services.fetch import FetchService
from user_options import user_options

uid = os.geteuid()
user_entry = pwd.getpwuid(uid)

# Full name is at index 4 (GECOS field); split/strip commas if needed
user_full_name = user_entry[4].split(',')[0].strip()

user = user_entry[0]
host = socket.gethostname()
user_address = f"{user}@{host}"

fetch = FetchService.get_default()
window_manager = WindowManager.get_default()

def format_uptime(value: tuple[int, int, int, int]) -> str:
    days, hours, minutes, seconds = value
    if days:
        return f"uptime: {days:02} days, {hours:02}:{minutes:02}"
    else:
        return f"uptime: {hours:02}:{minutes:02}"

class ControlCenter(widgets.RevealerWindow):
  def __init__(self, monitor_id: int):
    self.monitor_id = 0

    user_image = widgets.Picture(
        image=user_options.user.bind(
            "avatar",
            lambda value: "user-info" if not os.path.exists(value) else value,
        ),
        width=80,
        height=80,
        content_fit="cover",
        css_classes=["avatar"]
    )

    username = widgets.Box(
        child=[
            widgets.Label(
                label=user_full_name, css_classes=["user-name"], halign="start"
            ),
            widgets.Label(
                label=user_address, css_classes=["user-address"], halign="start"
            ),
            widgets.Label(
                label=utils.Poll(
                    timeout=60 * 1000, callback=lambda x: fetch.uptime
                ).bind("output", lambda value: format_uptime(value)),
                halign="start",
                css_classes=["user-uptime"],
            ),
        ],
        vertical=True,
        vexpand=True, valign="center",
        css_classes=["user-box"],
    )

    revealer = widgets.Revealer(
      transition_type="slide_left",
      child=widgets.Box(
        css_classes=["flyout", "elevation3"],
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
            css_classes=["section", "user-profile"],
            child=[
              user_image,
              username
            ]
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
