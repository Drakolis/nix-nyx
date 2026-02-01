from ignis.services.applications import (
  ApplicationsService,
  Application,
  ApplicationAction,
)
from ._base import LauncherActionDefinition, LauncherModeBase

applications = ApplicationsService.get_default()
applications_list = applications.apps


def map_application_to_action(app):
  return LauncherActionDefinition(
    title=app.name,
    description=app.description,
    icon=app.icon,
    action=lambda: app.launch(terminal_format="kitty -e %command%"),
  )


def app_search(query) -> [LauncherActionDefinition]:
  applications_list_filtered = (
    applications.search(applications_list, query) if query else applications_list
  )
  return [
    map_application_to_action(application) for application in applications_list_filtered
  ]


class LauncherModeApplications(LauncherModeBase):
  def __init__(self):
    super().__init__(
      name="Programs",
      placeholder="Search programs...",
      trigger="app:",
      search_function=app_search,
    )
