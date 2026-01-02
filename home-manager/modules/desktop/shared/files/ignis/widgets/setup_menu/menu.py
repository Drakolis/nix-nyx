from ignis import widgets
from widgets import Popover

class SetupMenuPopover(Popover):
  def __init__(self, child):
    super().__init__(
      child=widgets.Box(
        hexpand=True,
        css_classes=["popup", "elevation2", "setup-menu"],
        vertical=True,
        width_request=256,
        child=child
      )
    )
