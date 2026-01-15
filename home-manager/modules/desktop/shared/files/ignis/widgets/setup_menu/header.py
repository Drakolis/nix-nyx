from ignis import widgets


class SetupMenuHeader(widgets.Box):
  def __init__(self, title="Title", subtitle="Subtitle", **kwargs):
    super().__init__(
      **kwargs,
      vertical=True,
      child=[
        widgets.Label(
          halign="start",
          css_classes=["title-small", "setup-menu-title"],
          label=title,
        ),
        widgets.Label(
          halign="start",
          css_classes=["label-small", "setup-menu-subtitle"],
          label=subtitle,
          max_width_chars=30,
          ellipsize="end",
        ),
      ],
    )

  def set_title(self, title):
    self.child[0].set_label(title)

  def set_subtitle(self, subtitle):
    self.child[1].set_label(subtitle)
