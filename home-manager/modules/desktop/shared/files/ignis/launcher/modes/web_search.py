import asyncio
from ignis import utils
from ._base import LauncherActionDefinition, LauncherModeBase

search_engines = [
  {"name": "StartPage", "url": "https://www.startpage.com/sp/search?query="},
  {"name": "MyNixOS", "url": "https://mynixos.com/search?q="},
  {"name": "Ecosia", "url": "https://www.ecosia.org/search?q="},
]


def map_search_engines_to_action(search_engine, query):
  return LauncherActionDefinition(
    title=search_engine["name"],
    description=query,
    icon="web-browser",
    action=lambda: utils.exec_sh("xdg-open " + search_engine["url"] + query),
  )


class LauncherModeWebSearch(LauncherModeBase):
  def __init__(self):
    super().__init__(
      name="Web Search",
      placeholder="Search on Web...",
      trigger="web:",
      search_function=lambda query: [
        map_search_engines_to_action(search_engine, query)
        for search_engine in search_engines
      ],
    )
