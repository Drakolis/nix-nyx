from ignis.services.niri import NiriService
from utils import get_extended_app_icon
from ._base import LauncherActionDefinition, LauncherModeBase


niri = NiriService.get_default()


def map_niri_window_to_action(window):
  return LauncherActionDefinition(
    title=window.title,
    description=window.app_id,
    icon=get_extended_app_icon(window.app_id),
    action=lambda: window.focus(),
  )


def map_hypr_window_to_action(window):
  return LauncherActionDefinition(
    title=window.title,
    description=window.class_name,
    icon=get_extended_app_icon(window.class_name),
    # action=lambda: window.focus(),
  )


def niri_window_search(query) -> [LauncherActionDefinition]:
  windowsList = niri.windows
  query = query.lower()
  applicationsListFiltered = filter(
    lambda w: (query in w.title.lower()) or (query in w.app_id.lower()), windowsList
  )
  return [
    map_niri_window_to_action(application) for application in applicationsListFiltered
  ]


def hyprland_window_search(query) -> [LauncherActionDefinition]:
  windowsList = niri.windows
  query = query.lower()
  applicationsListFiltered = filter(
    lambda w: (query in w.title.lower()) or (query in w.class_name.lower()), windowsList
  )
  return [
    map_hypr_window_to_action(application) for application in applicationsListFiltered
  ]


class LauncherModeNiriWindows(LauncherModeBase):
  def __init__(self):
    super().__init__(
      name="Niri Windows",
      placeholder="Search open windows...",
      trigger="win:",
      search_function=niri_window_search,
    )
