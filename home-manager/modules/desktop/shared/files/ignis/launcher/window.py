from ignis import widgets
from ignis.services.applications import (
  ApplicationsService,
  Application,
  ApplicationAction,
)
from ignis.window_manager import WindowManager

window_manager = WindowManager.get_default()

applications = ApplicationsService.get_default()


class LauncherActionDefinition:
  def __init__(self, title, description, icon, action):
    self.title = title
    self.description = description
    self.icon = icon
    self.raw_action = action

  def action(self, *args):
    self.raw_action()
    window_manager.close_window("eggshell_launcher")


def map_application_to_action(app):
  return LauncherActionDefinition(
    title=app.name,
    description=app.description,
    icon=app.icon,
    action=lambda: app.launch(terminal_format="rio -e %command%"),
  )


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
    self.applications = applications.apps
    self.always_shown = []
    self.show_scroll = False

    self._app_list = widgets.Box(
      vertical=True,
      child=[],
    )

    self._app_list_scroll = widgets.Scroll(
      css_classes=["launcher-scroller"],
      child=self._app_list,
      height_request=250,
    )

    self.entry = widgets.Entry(
      vexpand=True,
      hexpand=True,
      placeholder_text="Search...",
      on_change=self.__search,
      on_accept=self.__on_accept,
    )

    revealer = widgets.Revealer(
      transition_type="crossfade",
      transition_duration=300,
      reveal_child=True,
      hexpand=True,
      vexpand=True,
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
                    pixel_size=25,
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

    container = widgets.Box(
      child=[revealer],
      vexpand=True,
    )

    super().__init__(
      namespace="eggshell_launcher",
      # monitor=niri.bind("active_output", lambda output: output == monitor_name),
      kb_mode="on_demand",
      popup=True,
      visible=False,
      layer="top",
      exclusivity="ignore",
      child=container,
      revealer=revealer,
      setup=lambda self: self.connect("notify::visible", self.__on_open),
    )
    self.__search()

  def __on_open(self, *args) -> None:
    if not self.visible:
      return

    self.entry.text = ""
    self.entry.grab_focus()

  def __on_accept(self, *args) -> None:
    if len(self._app_list.child) > 0:
      self.actions[0].child[0].action()

  def __search(self, *args) -> None:
    query = self.entry.text

    apps = applications.search(self.applications, query) if query else self.applications

    if query == "":
      self.entry.grab_focus()

    if apps == []:
      self._app_list.child = []
    else:
      self._app_list.child = [
        LauncherActionItem(map_application_to_action(application))
        for application in apps
      ]
