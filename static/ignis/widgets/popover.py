from gi.repository import Gtk  # type: ignore
from ignis.base_widget import BaseWidget
from ignis.gobject import IgnisProperty
from ignis.menu_model import IgnisMenuModel


class Popover(Gtk.Popover, BaseWidget):
  __gtype_name__ = "EggshellPopover"
  __gproperties__ = {**BaseWidget.gproperties}

  def __init__(self, **kwargs):
    Gtk.Popover.__init__(self)
    BaseWidget.__init__(self, visible=False, **kwargs)
