from ignis import utils

from ignis.services.applications import ApplicationsService, Application

applications = ApplicationsService.get_default()

DEFAULT_WINDOW_ICON = "application-default-icon"


def get_extended_app_icon(app_id) -> str:
  if app_id == "steam":
    return "com.valvesoftware.Steam"
  if app_id == "Element":
    return "element-desktop"
  elif app_id:
    return utils.get_app_icon_name(app_id)
  else:
    return DEFAULT_WINDOW_ICON


# def get_extended_app_icon_color(name) -> str:


def get_audio_device_icon(name_id) -> str:
  if "bluetooth" in name_id:
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

  if "bluetooth" in name_id:
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
