import asyncio
import datetime
import pytz
import aiohttp

from ignis import widgets
from ignis import utils
from user_options import user_options
from utils import get_weather_status_icon


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
          label=location_name,
          halign="start",
          max_width_chars=15,
          ellipsize="end",
        ),
        widgets.Label(
          css_classes=["timezone-time"],
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


class TimeOverview(widgets.Box):
  def __init__(self):
    super().__init__(
      width_request=300,
      vertical=True,
      css_classes=["section"],
      child=[
        widgets.Label(
          css_classes=[
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
        TimeZoneClock(location_name="Saint-Petersburg", location_tz="Europe/Moscow"),
        TimeZoneClock(location_name="Yekaterinburg", location_tz="Asia/Yekaterinburg"),
        TimeZoneClock(location_name="Belo Horizonte", location_tz="America/Sao_Paulo"),
      ],
    )

  def update_clocks(self):
    current_time = datetime.datetime.now()
    time_big = current_time.strftime("%H:%M:%S")
    time_format_short = "%H:%M"


class WeatherOverview(widgets.Box):
  def __init__(self, location):
    self.data = None
    self.location = location

    self.location_label = widgets.Label(
      halign="start",
      hexpand=True,
      label=self.location,
      css_classes=[
        "title-large",
        "emphasized",
        "weather-label-location",
      ],
    )

    self.temperature_label = widgets.Label(
      halign="end",
      hexpand=True,
      label="...",
      css_classes=[
        "title-large",
        "emphasized",
        "weather-label-temperature",
      ],
    )

    self.weather_icon = widgets.Icon(
      vexpand=True,
      image="process-working-symbolic",
      pixel_size=128,
      css_classes=["weather-label-weather", "animation-spin"],
    )

    self.weather_label = widgets.Label(
      halign="center",
      hexpand=True,
      label="Loading...",
      css_classes=[
        "title-large",
        "emphasized",
        "weather-label-weather",
      ],
    )

    self.humidity_label = widgets.Label(
      hexpand=True,
      label="H:...",
      css_classes=[
        "weather-label-humidity",
      ],
    )

    self.uv_label = widgets.Label(
      hexpand=True,
      label="UV:...",
      css_classes=[
        "weather-label-uv",
      ],
    )

    self.wind_label = widgets.Label(
      hexpand=True,
      label="W:...",
      css_classes=[
        "title-small",
        "emphasized",
        "weather-label-wind",
      ],
    )

    utils.Poll(
      timeout=30_60_000, callback=lambda x: asyncio.create_task(self.update_weather())
    )
    super().__init__(
      width_request=300,
      css_classes=["section", "weather-overview"],
      vertical=True,
      child=[
        widgets.Box(
          hexpand=True,
          child=[self.location_label, self.temperature_label],
        ),
        self.weather_icon,
        self.weather_label,
        widgets.Box(
          hexpand=True,
          homogeneous=True,
          child=[
            self.humidity_label,
            self.uv_label,
            self.wind_label,
          ],
        ),
      ],
    )

  async def update_weather(self):
    async with aiohttp.ClientSession() as session:
      async with session.get(f"https://wttr.in/{self.location}?format=j1") as response:
        json = await response.json()
        current = json["current_condition"][0]
        temperature = current["temp_C"]
        humidity = current["humidity"]
        uv_index = current["uvIndex"]
        weather_code = current["weatherCode"]
        weather = current["weatherDesc"][0]["value"]
        windspeed = current["windspeedKmph"]
        sign = "" if "-" in temperature else "+"
        self.temperature_label.label = f"{sign}{temperature}°C"
        self.weather_label.label = weather
        self.humidity_label.label = f"H: {humidity}%"
        self.uv_label.label = f"UV: {uv_index}"
        self.wind_label.label = f"W: {windspeed}kmh"
        self.weather_icon.image = get_weather_status_icon(weather_code)
        self.weather_icon.css_classes = ["weather-label-weather"]


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
              TimeOverview(),
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
              WeatherOverview(location="Berlin"),
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
