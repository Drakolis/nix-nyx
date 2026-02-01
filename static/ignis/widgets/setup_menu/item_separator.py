from ignis import widgets


class SetupMenuItemSeparator(widgets.Box):
  def __init__(self, **kwargs):
    super().__init__(**kwargs, css_classes=["setup-menu-separator"])
