def map_applications_to_action_list(app):
  return {
    "title": app.name,
    "description": app.description,
    "icon-name": app.icon,
    "action": lambda x: app.launch(terminal_format="kitty %command%"),
  }


class LauncherWindow:
  def __init__(self):
    self.monitor_id = 0

    # title,
    # description?,
    # icon,
    # action
    self.applications = applications.apps
    self.action_list = [map_applications_to_action_list(a) for a in self.applications]
    self.always_shown = []

    self.window = widgets.Window(
      namespace=f"eggshell_launcher_{self.monitor_id}",
      anchor=["bottom"],  # DELETE ME
      monitor=self.monitor_id,
      kb_mode="on_demand",
      child=widgets.Box(
        css_classes=["launcher-container", "has-outline", "has-shadow"],
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
                  widgets.Icon(image="search", pixel_size=16),
                  widgets.Entry(
                    vexpand=True,
                    hexpand=True,
                    placeholder_text="Search...",
                    on_accept=lambda x: print(x.text),
                    on_change=lambda x: print(x.text),
                  ),
                ],
              ),
              widgets.Scroll(
                child=widgets.Box(
                  vertical=True,
                  child=[
                    self.launcher_item(action_item) for action_item in self.action_list
                  ],
                ),
                height_request=250,
              ),
              widgets.Box(
                hexpand=True,
                css_classes=["launcher-footer"],
                spacing=5,
                child=[
                  widgets.Button(
                    on_click=lambda x: self.launch_app(),
                    child=widgets.Icon(image="settings", pixel_size=16),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    )

  def launcher_item(self, action_item):
    return widgets.Button(
      css_classes=["launcher-item"],
      child=widgets.Box(
        hexpand=True,
        child=[
          widgets.Icon(image=action_item["icon-name"], pixel_size=52),
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
                label=action_item["title"],
              ),
              (
                widgets.Label(
                  css_classes=["launcher-item-label-description"],
                  halign="start",
                  hexpand=True,
                  justify="left",
                  label=action_item["description"],
                )
                if action_item["description"]
                else None
              ),
            ],
          ),
        ],
      ),
    )

  def widget(self, monitor_id: int):
    self.monitor_id = monitor_id
    return self.window
