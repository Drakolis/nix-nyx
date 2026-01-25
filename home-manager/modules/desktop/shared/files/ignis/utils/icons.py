from ignis import utils

from ignis.services.applications import ApplicationsService, Application

applications = ApplicationsService.get_default()

DEFAULT_WINDOW_ICON = "application-default-icon"


def get_extended_app_icon(app_id) -> str:
  if app_id == "steam":
    return "com.valvesoftware.Steam"
  elif app_id == "Slack":
    return "com.slack.Slack"
  elif app_id == "Element":
    return "element-desktop"
  elif app_id:
    return utils.get_app_icon_name(app_id)
  else:
    return DEFAULT_WINDOW_ICON


# def get_extended_app_icon_color(name) -> str:


def get_audio_device_icon(name_id) -> str:
  if "bluez_output" in name_id:
    return "bluetooth-symbolic"
  elif "hdmi" in name_id:
    return "video-display-symbolic"
  elif "alsa_output.pci" in name_id:
    return "audio-card-symbolic"
  elif "SPDIF" in name_id:
    return "audio-card-symbolic"
  elif "Headphones" in name_id:
    return "audio-headphones-symbolic"
  elif "Speaker" in name_id:
    return "audio-speakers-symbolic"
  elif "alsa_output.usb" in name_id:
    return "audio-card-usb-symbolic"

  if "bluez_input" in name_id:
    return "bluetooth-symbolic"
  if "alsa_input.pci" in name_id:
    return "audio-card-symbolic"
  elif "Mic" in name_id:
    return "audio-input-microphone-symbolic"
  elif "Line" in name_id:
    return "audio-input-microphone-symbolic"
  elif "Webcam" in name_id:
    return "camera-web-symbolic"
  elif "alsa_input.usb" in name_id:
    return "audio-card-usb-symbolic"


def get_audio_output_status_icon(volume, is_muted) -> str:
  if is_muted:
    return "audio-volume-muted-symbolic"
  elif volume > 200:
    return "audio-volume-high-danger-symbolic"
  elif volume > 100:
    return "audio-volume-high-warning-symbolic"
  elif volume > 65:
    return "audio-volume-high-symbolic"
  elif volume > 32:
    return "audio-volume-medium-symbolic"
  elif volume > 0:
    return "audio-volume-low-symbolic"
  else:
    return "audio-volume-muted-symbolic"


def get_audio_input_status_icon(volume, is_muted) -> str:
  if is_muted:
    return "audio-input-microphone-muted-symbolic"
  elif volume > 65:
    return "audio-input-microphone-high-symbolic"
  elif volume > 32:
    return "audio-input-microphone-medium-symbolic"
  elif volume > 0:
    return "audio-input-microphone-low-symbolic"
  else:
    return "audio-input-microphone-muted-symbolic"


def get_brightness_status_icon(brightness_percent) -> str:
  if brightness_percent > 65:
    return "display-brightness-high-symbolic"
  elif brightness_percent > 32:
    return "display-brightness-medium-symbolic"
  elif brightness_percent > 0:
    return "display-brightness-low-symbolic"
  else:
    return "display-brightness-off-symbolic"


# def get_kbd_backlight_status_icon(brightness_percent) -> str:

# def get_battery_status_icon(charge_percent, is_worn) -> str:

# def get_network_status_icon(volume, is_muted) -> str:

# def get_bluetooth_status_icon(volume, is_muted) -> str:


def get_weather_status_icon(weather_code) -> str:
  weather_dictionary = {
    "113": "weather-clear-symbolic",  # Clear/Sunny
    "116": "weather-few-clouds-symbolic",  # Partly Cloudy
    "119": "weather-overcast-symbolic",  # Cloudy
    "122": "weather-overcast-symbolic",  # Overcast
    "143": "weather-fog-symbolic",  # Mist
    "176": "weather-showers-scattered-symbolic",  # Patchy Rain Showers
    "179": "weather-snow-symbolic",  # Patchy Snow Showers
    "182": "weather-snow-symbolic",  # Patchy Sleet
    "185": "weather-showers-scattered-symbolic",  # Patchy Freezing Drizzle
    "200": "weather-storm-symbolic",  # Thundery Showers
    "227": "weather-windy-symbolic",  # Blowing Snow
    "230": "weather-windy-symbolic",  # Blizzard
    "248": "weather-fog-symbolic",  # Fog
    "260": "weather-fog-symbolic",  # Freezing Fog
    "263": "weather-showers-scattered-symbolic",  # Light Drizzle
    "266": "weather-showers-scattered-symbolic",  # Drizzle
    "281": "weather-showers-scattered-symbolic",  # Freezing Drizzle
    "284": "weather-showers-scattered-symbolic",  # Heavy Freezing Drizzle
    "293": "weather-showers-symbolic",  # Light Rain
    "296": "weather-showers-symbolic",  # Rain
    "299": "weather-showers-symbolic",  # Moderate Rain
    "302": "weather-showers-symbolic",  # Heavy Rain
    "305": "weather-severe-alert-symbolic",  # Torrential Rain
    "308": "weather-severe-alert-symbolic",  # Extreme Rain
    "311": "weather-showers-scattered-symbolic",  # Light Freezing Rain
    "314": "weather-severe-alert-symbolic",  # Freezing Rain
    "317": "weather-snow-symbolic",  # Light Sleet
    "320": "weather-snow-symbolic",  # Sleet
    "323": "weather-snow-symbolic",  # Light Snow
    "326": "weather-snow-symbolic",  # Patchy Light Snow
    "329": "weather-snow-symbolic",  # Moderate Snow
    "332": "weather-snow-symbolic",  # Heavy Snow
    "335": "weather-severe-alert-symbolic",  # Blizzard
    "338": "weather-severe-alert-symbolic",  # Heavy Blizzard
    "350": "weather-severe-alert-symbolic",  # Ice Pellets
    "353": "weather-showers-symbolic",  # Light Rain Showers
    "356": "weather-showers-symbolic",  # Rain Showers
    "359": "weather-showers-symbolic",  # Heavy Rain Showers
    "362": "weather-snow-symbolic",  # Light Sleet Showers
    "365": "weather-snow-symbolic",  # Sleet Showers
    "368": "weather-snow-symbolic",  # Light Snow Showers
    "371": "weather-snow-symbolic",  # Heavy Snow Showers
    "374": "weather-severe-alert-symbolic",  # Light Ice Pellet Showers
    "377": "weather-severe-alert-symbolic",  # Ice Pellet Showers
    "386": "weather-storm-symbolic",  # Thundery Showers
    "389": "weather-storm-symbolic",  # Thunderstorms
    "392": "weather-storm-symbolic",  # Thundery Snow Showers
    "395": "weather-severe-alert-symbolic",  # Snowstorm
  }
  return weather_dictionary[weather_code]
