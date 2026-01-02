from ast import Lambda
from ignis import widgets
from ignis import utils

from ignis.window_manager import WindowManager
from ignis.services.applications import ApplicationsService, Application

from utils import get_extended_app_icon

class LauncherTouchItem(widgets.Button):
  def __init__(self, application: Application, close_launcher):
    app_id = application.id
    name = application.name
    icon = application.icon

    super().__init__(
      css_classes=["tile"],
      child=widgets.Box(
        css_classes=["tile-container"],
        vertical=True,
        child=[
          widgets.Icon(
            css_classes=["tile-icon"],
            image=(icon+"-symbolic"),
            pixel_size=64,
          ),
          widgets.Label(
            hexpand=True,
            halign="start",
            css_classes=["tile-title"],
            label=name,
            ellipsize='end',
            max_width_chars=52
          ),
        ]
      ),
      tooltip_text=name,
      on_click=lambda x: self.launch(),
      # on_right_click=lambda x: menu_widget.popup(),
    )

    self.application = application
    self.close_launcher = close_launcher

  def launch(self):
    self.application.launch()
    self.close_launcher()


class LauncherTouch(widgets.RevealerWindow):
  def __init__(self, monitor_id: int):
    self.monitor_id = 0
    self.timeout = False
    self.applications = ApplicationsService.get_default()
    self.applications_list = self.applications.apps

    # self.action_list = [
    #  map_applications_to_action_list(a) for a in self.applications
    # ]

    self.app_grid = widgets.Scroll(
      vexpand=True,
      has_frame=True,
      hscrollbar_policy="always",
      child=widgets.Grid(
        css_classes=["launcher-grid"],
        valign="center",
        child=[LauncherTouchItem(x, lambda: self.set_visible(False)) for x in self.applications_list],
        row_num=4,
        vexpand=True
      )
    );

    revealer = widgets.Revealer(
      transition_type="crossfade",
      transition_duration=300,
      reveal_child=True,
      hexpand=True,
      vexpand=True
    )

    container = widgets.EventBox(
      child=[revealer],
      css_classes=["popup"],
      vexpand=True,
      # on_hover=self.on_hover_handler,
      # on_hover_lost=self.on_hover_lost_handler,
    )

    super().__init__(
      namespace=f"eggshell_launcher_touch_{monitor_id}",
      visible=False,
      layer="top",
      exclusivity="ignore",
      anchor=["bottom", "top", "left", "right"],
      child=container,
      revealer=revealer,
      kb_mode="on_demand", # TODO: Keyboard navigation
      popup=True,
    )
    self.container = container
    self.revealer = revealer

    self.revealer.set_child(self.app_grid)
