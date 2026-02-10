from enum import Enum

from ignis import widgets
from ignis.gobject import IgnisProperty


class TablerIconsEnum(Enum):
  DEFAULT = 0xEC8F
  AUDIO_OUT_HIGH = 0xEB51
  AUDIO_OUT_MEDIUM = 0xEB4F
  AUDIO_OUT_LOW = 0x1019D
  AUDIO_OUT_NONE = 0xEB50
  AUDIO_OUT_OFF = 0xF1C3
  AUDIO_IN_ON = 0xEF2C
  AUDIO_IN_OFF = 0xF40D
  BULB_ON = 0xEA51
  BULB_OFF = 0xEA50
  CLOCK_ROUND = 0xEA70
  CLOCK_SQUARE = 0xF099
  COFFEE_MUG_ON = 0xEF0E
  COFFEE_MUG_OFF = 0xF106
  COFFEE_CUP_ON = 0xEF28
  COFFEE_CUP_OFF = 0xF10D
  MUSIC = 0xEAFC
  PLAYER_EJECT = 0xEFBC
  PLAYER_PAUSE = 0xED45
  PLAYER_PLAY = 0xED46
  PLAYER_RECORD = 0xED47
  PLAYER_SKIP_BACK = 0xED48
  PLAYER_SKIP_FORWARD = 0xED49
  PLAYER_STOP = 0xED4A
  PLAYER_TRACK_NEXT = 0xED4B
  PLAYER_TRACK_PREVIOUS = 0xED4C


class TablerIcon(widgets.Label):
  def __init__(
    self, icon: TablerIconsEnum = TablerIconsEnum.DEFAULT, css_classes=[], **kwargs
  ):
    self._icon: TablerIconsEnum = icon
    super().__init__(**kwargs, css_classes=[*css_classes, "tabler-icon"])
    self.label = chr(self._icon.value)

  @IgnisProperty
  def icon(self) -> TablerIconsEnum:
    return self._icon

  @icon.setter
  def icon(self, icon: TablerIconsEnum):
    self._icon = icon
    self.label = chr(icon.value)
