from ignis import widgets
from .modes import LauncherModesManager


class LauncherActionItem(widgets.Button):
  def __init__(self, action_definition):
    title = action_definition.title
    description = action_definition.description
    icon = action_definition.icon
    action = action_definition.action

    super().__init__(
      on_click=lambda _: action(),
      css_classes=["launcher-item"],
      child=widgets.Box(
        hexpand=True,
        child=[
          widgets.Icon(image=icon, pixel_size=52),
          widgets.Box(
            css_classes=["launcher-item-label"],
            vertical=True,
            vexpand=True,
            valign="center",
            child=[
              widgets.Label(
                css_classes=["launcher-item-label-title"],
                halign="start",
                hexpand=True,
                justify="left",
                label=title,
                max_width_chars=50,
                ellipsize="end",
              ),
              (
                widgets.Label(
                  css_classes=["launcher-item-label-description"],
                  halign="start",
                  hexpand=True,
                  justify="left",
                  label=description,
                  ellipsize="end",
                )
                if description
                else None
              ),
            ],
          ),
        ],
      ),
    )

    self.title = title
    self.description = description
    self.icon = icon
    self.action = action


class LauncherWindow(widgets.RevealerWindow):
  def __init__(self):
    self.always_shown = []
    self.show_scroll = False
    self.modes_manager = LauncherModesManager()

    self._app_list = widgets.Box(
      vertical=True,
    )

    self._app_list_scroll = widgets.Scroll(
      # css_classes=["launcher-scroller"],
      child=self._app_list,
      min_content_height=0,
      max_content_height=500,
      propagate_natural_height=True,
    )

    self.entry = widgets.Entry(
      vexpand=True,
      hexpand=True,
      on_change=self.__search,
      on_accept=self.__on_accept,
    )

    revealer = widgets.Revealer(
      transition_type="crossfade",
      transition_duration=150,
      reveal_child=True,
      child=widgets.Box(
        css_classes=["launcher-container", "elevation5"],
        child=[
          widgets.Box(
            hexpand=True,
            vertical=True,
            child=[
              widgets.Box(
                hexpand=True,
                css_classes=["launcher-input"],
                spacing=5,
                child=[
                  widgets.Icon(
                    css_classes=["launcher-input-icon"],
                    image="search-symbolic",
                    pixel_size=24,
                  ),
                  self.entry,
                ],
              ),
              self._app_list_scroll,
            ],
          )
        ],
      ),
    )

    container = widgets.Box(child=[revealer], valign="start")

    super().__init__(
      namespace="eggshell_launcher",
      css_classes=["unset-window"],
      # monitor=niri.bind("active_output", lambda output: output == monitor_name),
      kb_mode="exclusive",
      popup=True,
      visible=False,
      layer="top",
      exclusivity="ignore",
      child=container,
      revealer=revealer,
      height_request=500,
      setup=lambda self: self.connect("notify::visible", self.__on_open),
    )

  def __on_open(self, *args) -> None:
    if not self.visible:
      return

    self.entry.text = ""
    self.entry.grab_focus()

    self.modes_manager.register_modes()
    self.__switch_mode(self.modes_manager.default_mode)

    self.__search()

  def __on_accept(self, *args) -> None:
    if len(self._app_list.child) > 0:
      self._app_list.child[0].action()

  def __switch_mode(self, launcher_mode):
    self.launcher_mode = launcher_mode
    self.entry.placeholder_text = self.launcher_mode.placeholder
    self.entry.text = ""

  def __search(self, *args) -> None:
    query = self.entry.text

    if query in self.modes_manager.mode_triggers:
      self.__switch_mode(self.modes_manager.get_mode_by_trigger(query))

    if query == "":
      self.entry.grab_focus()

    self._app_list.child = [
      LauncherActionItem(action) for action in self.launcher_mode.search_function(query)
    ]
