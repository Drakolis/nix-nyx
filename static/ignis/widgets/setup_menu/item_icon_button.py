from ignis import widgets


class SetupMenuItemIconButton(widgets.Button):
  def __init__(
    self,
    setup_button=None,
    setup_icon=None,
    on_click=None,
    is_active=False,
    active_css_class="active",
    label="Capy?",
    icon="device-symbolic",
    **kwargs,
  ):
    self._icon = icon
    self._css_classes_icon = ["setup-menu-button-icon-image"]
    self._css_classes_icon_container = ["setup-menu-button-icon"]
    self._active_css_classes = [active_css_class]

    self.icon_widget = widgets.Icon(
      css_classes=self._css_classes_icon,
      image=icon,
      pixel_size=24,
    )

    icon_container_widget = widgets.Box(
      setup=setup_icon,
      css_classes=self._css_classes_icon_container,
      child=[self.icon_widget],
    )

    super().__init__(
      **kwargs,
      on_click=on_click,
      setup=setup_button,
      css_classes=["setup-menu-button"],
      child=widgets.Box(
        child=[
          icon_container_widget,
          widgets.Label(
            label=label,
            max_width_chars=30,
            ellipsize="end",
          ),
        ]
      ),
    )
    self.icon_container_widget = icon_container_widget
    self.set_active(is_active)

  def set_icon(self, new_icon):
    self.icon_widget.image = new_icon

  def add_icon_class(self, new_class):
    self.icon_widget.css_classes = self.icon_widget.css_classes + [new_class]

  def reset_icon(self):
    self.icon_widget.image = self._icon

  def reset_icon_class(self):
    self.icon_widget.css_classes = self._css_classes_icon

  def set_active(self, is_active):
    if not is_active:
      self.icon_container_widget.css_classes = self._css_classes_icon_container
    else:
      self.icon_container_widget.css_classes = (
        self._css_classes_icon_container + self._active_css_classes
      )
