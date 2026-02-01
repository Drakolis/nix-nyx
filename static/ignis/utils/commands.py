from ignis import utils


async def send_notification(summary, text="", icon=""):
  command = "notify-send "
  if icon:
    command = command + f"-i {icon} "
  command = command + f'"{summary}" '
  if text:
    command = command + f'"{text}" '
  print(command)
  await utils.exec_sh_async(command)
