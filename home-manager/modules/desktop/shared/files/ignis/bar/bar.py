from ignis import widgets

from bar.widgets import (
  workspaces_widget,
  WindowTitleWidget,
  system_tray_widget,
  system_status_widget,
  system_indicators_widget,
  date_time_widget,
  mpris_status_widget,
)


class Bar(widgets.Window):
  def __init__(self, monitor_id):
    self.monitor_id = monitor_id

    super().__init__(
      namespace=f"eggshell_bar_{monitor_id}",
      monitor=monitor_id,
      anchor=["left", "top", "right"],
      exclusivity="exclusive",
      layer="top",
      css_classes=["unset-window"],
      child=widgets.CenterBox(
        css_classes=["bar-container"],
        start_widget=widgets.Box(
          child=[
            workspaces_widget(monitor_id),
            mpris_status_widget(),
            WindowTitleWidget(monitor_id),
          ]
        ),
        center_widget=widgets.Box(
          child=[
            date_time_widget(),
          ]
        ),
        end_widget=widgets.Box(
          child=[
            system_indicators_widget(),
            system_status_widget(monitor_id),
            system_tray_widget(),
          ]
        ),
      ),
    )
