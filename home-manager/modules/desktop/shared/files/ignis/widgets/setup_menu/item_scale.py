from ignis import widgets


class ScaleSetupMenuItem(widgets.Box):
  def __init__(
    self,
    min=0,
    max=100,
    step=1,
    value=0,
    on_change=None,
    icon_min=None,
    icon_max=None,
    icon_css_classes=[],
    scale_css_class=None,
    **kwargs,
  ):
    scale = widgets.Scale(
      hexpand=True,
      css_classes=["slider-small", scale_css_class],
      value=value,
      min=min,
      max=max,
      step=step,
    )

    super().__init__(
      **kwargs,
      css_classes=["setup-menu-item"],
      spacing=10,
      child=[
        widgets.Icon(css_classes=icon_css_classes, image=icon_min, pixel_size=22)
        if icon_min
        else None,
        scale,
        widgets.Icon(css_classes=icon_css_classes, image=icon_max, pixel_size=22)
        if icon_max
        else None,
      ],
    )
    self.scale = scale

  def set_value(self, value):
    self.scale.set_value(value)

  def set_on_change(self, on_change):
    self.scale.connect("value-changed", lambda v: on_change(v))
