import asyncio
from ignis import utils
from ._base import LauncherActionDefinition, LauncherModeBase

from utils import send_notification


def map_kill_query_to_action(query):
  async def kill_and_notify():
    out = await utils.exec_sh_async(f"pkill -e {query}")

    print(out.stdout)
    await send_notification(
      icon="process-stop-symbolic",
      summary="Process killed" if len(out.stdout) > 0 else "Nothing killed",
      text=out.stdout.rstrip("\n")
      if len(out.stdout) > 0
      else f'No processes matching \\"{query}\\" were found',
    )

  return LauncherActionDefinition(
    title=f'Kill "{query}"',
    icon="process-stop-symbolic",
    action=lambda: asyncio.create_task(kill_and_notify()),
  )


def kill_process_search(query) -> [LauncherActionDefinition]:
  query = query.lower()
  return [map_kill_query_to_action(query)] if query else []


class LauncherModePKill(LauncherModeBase):
  def __init__(self):
    super().__init__(
      name="PKill",
      placeholder="Kill running process...",
      trigger="kill:",
      search_function=kill_process_search,
    )
