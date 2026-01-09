from ignis import widgets


class SetupMenuItemIconButton(widgets.Button):
  def __init__(
    self,
    setup_button=None,
    setup_icon=None,
    on_click=None,
    label="Capy?",
    icon="audio-card-symbolic",
    **kwargs,
  ):
    super().__init__(
      **kwargs,
      on_click=on_click,
      setup=setup_button,
      css_classes=["setup-menu-button"],
      child=widgets.Box(
        child=[
          widgets.Box(
            setup=setup_icon,
            css_classes=["setup-menu-button-icon"],
            child=[
              widgets.Icon(
                css_classes=["setup-menu-button-icon-image"],
                image=icon,
                pixel_size=24,
              )
            ],
          ),
          widgets.Label(
            label=label,
            max_width_chars=30,
            ellipsize="end",
          ),
        ]
      ),
    )
