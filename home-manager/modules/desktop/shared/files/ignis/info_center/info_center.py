import asyncio
import datetime
import pytz

from ignis import widgets
from ignis import utils
from user_options import user_options


class InfoCenter(widgets.RevealerWindow):
  def __init__(self):
    revealer = widgets.Revealer(
      transition_type="slide_down",
      child=widgets.Box(
        css_classes=["flyout-down", "elevation3"],
        spacing=12,
        vexpand=True,
        vertical=True,
        child=[
          widgets.Label(
            label="Information Center",
            css_classes=["title-medium"],
            valign="start",
            halign="start",
          ),
          widgets.Box(
            spacing=12,
            child=[
              widgets.Box(
                width_request=300,
                vertical=True,
                css_classes=["section"],
                child=[
                  widgets.Label(
                    css_classes=[
                      "clock-label",
                      "display-small",
                      "monospace",
                      "local-time",
                    ],
                    valign="end",
                    hexpand=True,
                    label=utils.Poll(
                      1_000,
                      lambda self: datetime.datetime.now().strftime("%H:%M:%S"),
                    ).bind("output"),
                  ),
                  widgets.Box(
                    hexpand=True,
                    spacing=5,
                    css_classes=["time-section"],
                    child=[
                      widgets.Label(
                        vexpand=True,
                        hexpand=True,
                        css_classes=["title-small"],
                        label="Berlin",
                        halign="start",
                        max_width_chars=15,
                        ellipsize="end",
                      ),
                      widgets.Label(
                        css_classes=["clock-label", "headline-medium", "monospace"],
                        vexpand=True,
                        hexpand=True,
                        halign="end",
                        label=utils.Poll(
                          1_000,
                          lambda self: datetime.datetime.now(
                            tz=pytz.timezone("Europe/Berlin")
                          ).strftime("%H:%M"),
                        ).bind("output"),
                      ),
                    ],
                  ),
                  widgets.Box(
                    hexpand=True,
                    spacing=5,
                    css_classes=["time-section"],
                    child=[
                      widgets.Label(
                        vexpand=True,
                        hexpand=True,
                        css_classes=["title-small"],
                        label="Saint-Petersburg",
                        halign="start",
                        max_width_chars=15,
                        ellipsize="end",
                      ),
                      widgets.Label(
                        css_classes=["clock-label", "headline-medium", "monospace"],
                        vexpand=True,
                        hexpand=True,
                        halign="end",
                        label=utils.Poll(
                          1_000,
                          lambda self: datetime.datetime.now(
                            tz=pytz.timezone("Europe/Moscow")
                          ).strftime("%H:%M"),
                        ).bind("output"),
                      ),
                    ],
                  ),
                  widgets.Box(
                    hexpand=True,
                    spacing=5,
                    css_classes=["time-section"],
                    child=[
                      widgets.Label(
                        vexpand=True,
                        hexpand=True,
                        css_classes=["title-small"],
                        label="Yekaterinburg",
                        halign="start",
                        max_width_chars=15,
                        ellipsize="end",
                      ),
                      widgets.Label(
                        css_classes=["clock-label", "headline-medium", "monospace"],
                        vexpand=True,
                        hexpand=True,
                        halign="end",
                        label=utils.Poll(
                          1_000,
                          lambda self: datetime.datetime.now(
                            tz=pytz.timezone("Asia/Yekaterinburg")
                          ).strftime("%H:%M"),
                        ).bind("output"),
                      ),
                    ],
                  ),
                  widgets.Box(
                    hexpand=True,
                    spacing=5,
                    css_classes=["time-section"],
                    child=[
                      widgets.Label(
                        vexpand=True,
                        hexpand=True,
                        css_classes=["title-small"],
                        label="Belo Horizonte",
                        halign="start",
                        max_width_chars=15,
                        ellipsize="end",
                      ),
                      widgets.Label(
                        css_classes=["clock-label", "headline-medium", "monospace"],
                        vexpand=True,
                        hexpand=True,
                        halign="end",
                        label=utils.Poll(
                          1_000,
                          lambda self: datetime.datetime.now(
                            tz=pytz.timezone("America/Sao_Paulo")
                          ).strftime("%H:%M"),
                        ).bind("output"),
                      ),
                    ],
                  ),
                ],
              ),
              widgets.Box(
                width_request=300,
                css_classes=["section"],
                child=[
                  widgets.Calendar(
                    css_classes=["colorful-calendar"],
                    # no_month_change=False,
                    show_day_names=True,
                    # show_details=True,
                    show_heading=True,
                    show_week_numbers=False,
                  )
                ],
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
      namespace="eggshell_info_center",
      css_classes=["unset-window"],
      visible=False,
      layer="top",
      anchor=["top"],
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
