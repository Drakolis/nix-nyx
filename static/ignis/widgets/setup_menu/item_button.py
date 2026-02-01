from ignis import widgets


class SetupMenuItemButton(widgets.Button):
  def __init__(self, on_click=None, label="Capy?", **kwargs):
    super().__init__(
      **kwargs,
      css_classes=["setup-menu-button"],
      on_click=on_click,
      child=widgets.Label(halign="start", label=label),
    )
