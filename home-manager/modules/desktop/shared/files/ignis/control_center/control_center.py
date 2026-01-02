notifications = NotificationService.get_default()

class ControlCenterWindow(widgets.RevealerWindow):
  def __init__(self, monitor_id: int):
    self.monitor_id = monitor_id

    revealer = widgets.Revealer(
      transition_type="slide_down",
      child=widgets.Box(
        css_classes=["popup", "elevation2"],
        child=[
          widgets.Box(
            css_classes=["control"],
            child=[widgets.Label(label="Control Center")],
          )
        ],
        vertical=True,
        hexpand=True,
      ),
      transition_duration=300,
      reveal_child=True,
      hexpand=True,
    )

    container = widgets.EventBox(
      child=[revealer],
      on_hover_lost=self.on_hover_lost_handler,
    )

    super().__init__(
      visible=False,
      popup=True,
      kb_mode="on_demand",
      layer="top",
      anchor=["right", "top"],
      namespace=f"eggshell_control_center_{monitor_id}",
      revealer=revealer,
      child=container,
    )

  def on_hover_lost_handler(self, *args):
    self.close_window()

  def open_window(self):
    self.set_visible(True)

  def close_window(self):
    self.set_visible(False)
