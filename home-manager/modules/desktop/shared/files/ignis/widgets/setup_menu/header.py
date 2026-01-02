from ignis import widgets

class SetupMenuHeader(widgets.Box):
  def __init__(self, title="Title", subtitle="Subtitle", **kwargs):
    super().__init__(
      **kwargs,
      vertical=True,
      child=[
        widgets.Label(
          halign="start",
          css_classes=["title-medium", "setup-menu-title"],
          label=title,
        ),
        widgets.Label(
          halign="start",
          css_classes=["label-large", "setup-menu-subtitle"],
          label=subtitle,
        ),
      ]
    )

  def set_title(self, title):
    self.child[0].set_label(title)

  def set_subtitle(self, subtitle):
    self.child[1].set_label(subtitle)
