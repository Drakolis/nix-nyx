import asyncio

from ignis import utils

from ._base import LauncherActionDefinition, LauncherModeBase


def map_cliphist_to_action(cliphist_entry):
  async def copy_from_ch(cliphist_id):
    await utils.exec_sh_async((f"cliphist decode {cliphist_id} | wl-copy"))

  cliphist_split = cliphist_entry.split("\t")
  cliphist_id = cliphist_split[0]
  cliphist_preview = cliphist_split[1]
  return LauncherActionDefinition(
    title=cliphist_preview,
    description=cliphist_id,
    icon="clipboard-symbolic",
    action=lambda: asyncio.create_task(copy_from_ch(cliphist_id)),
  )


class LauncherModeClipboard(LauncherModeBase):
  def __init__(self):
    def fake_search(query) -> [LauncherActionDefinition]:
      cliphist = utils.exec_sh("cliphist list").stdout
      clipboard = [line for line in cliphist.splitlines() if query in line][:10]

      return [map_cliphist_to_action(entry) for entry in clipboard]

    super().__init__(
      name="Clipboard History",
      placeholder="Search cliphist...",
      trigger="ch:",
      search_function=fake_search,
    )
