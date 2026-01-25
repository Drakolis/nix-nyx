import asyncio
import datetime
import pytz

from ignis import widgets
from ignis import utils
from user_options import user_options


class TimeZoneClock(widgets.Box):
  def __init__(self, location_name, location_tz):
    super().__init__(
      hexpand=True,
      spacing=5,
      css_classes=["time-section"],
      child=[
        widgets.Label(
          vexpand=True,
          hexpand=True,
          css_classes=["title-small"],
          label=location_name,
          halign="start",
          max_width_chars=15,
          ellipsize="end",
        ),
        widgets.Label(
          css_classes=["clock-label", "headline-medium"],
          vexpand=True,
          hexpand=True,
          halign="end",
          label=utils.Poll(
            1_000,
            lambda self: datetime.datetime.now(tz=pytz.timezone(location_tz)).strftime(
              "%H:%M"
            ),
          ).bind("output"),
        ),
      ],
    )


class InfoCenter(widgets.RevealerWindow):
  def __init__(self):
    revealer = widgets.Revealer(
      transition_type="slide_down",
      child=widgets.Box(
        css_classes=["flyout", "elevation3"],
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
                      "local-time",
                    ],
                    valign="end",
                    hexpand=True,
                    label=utils.Poll(
                      1_000,
                      lambda self: datetime.datetime.now().strftime("%H:%M:%S"),
                    ).bind("output"),
                  ),
                  TimeZoneClock(location_name="UTC", location_tz="UTC"),
                  TimeZoneClock(
                    location_name="Saint-Petersburg", location_tz="Europe/Moscow"
                  ),
                  TimeZoneClock(
                    location_name="Yekaterinburg", location_tz="Asia/Yekaterinburg"
                  ),
                  TimeZoneClock(
                    location_name="Belo Horizonte", location_tz="America/Sao_Paulo"
                  ),
                ],
              ),
              widgets.Box(
                width_request=350,
                css_classes=["section"],
                child=[
                  widgets.Calendar(
                    hexpand=True,
                    css_classes=["colorful-calendar"],
                    # no_month_change=False,
                    show_day_names=True,
                    # show_details=True,
                    show_heading=True,
                    show_week_numbers=False,
                  )
                ],
              ),
              widgets.Box(
                width_request=300,
                css_classes=["section"],
                vertical=True,
                child=[
                  widgets.Box(
                    hexpand=True,
                    child=[
                      widgets.Label(
                        halign="start",
                        hexpand=True,
                        label="+1",
                        css_classes=["title-large"],
                      ),
                      widgets.Label(
                        halign="end",
                        hexpand=True,
                        label="+3",
                        css_classes=["title-large"],
                      ),
                    ],
                  ),
                  widgets.Icon(vexpand=True, image="weather-clear-symbolic", pixel_size=128),
                  widgets.Label(halign="center", label=utils.Poll(
                      1_000,
                      lambda self: datetime.datetime.now().strftime("%H:%M:%S"),
                    ).bind("output"),),
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
