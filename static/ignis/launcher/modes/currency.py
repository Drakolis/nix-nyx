import requests
from ignis import utils

from ._base import LauncherActionDefinition, LauncherModeBase

API_URL = "https://open.er-api.com/v6/latest/USD"


def fetch_rates():  # TODO: Should be cached every hour
  response = requests.get(API_URL)
  response.raise_for_status()
  data = response.json()
  rates = data["rates"]
  return rates


def convert_int(s, d):
  try:
    i = int(s)
  except ValueError:
    i = d
  return i


def map_currency_to_action(
  value_source, currency_source, value_target, currency_target
):
  display = (
    f"{value_source:.2f} {currency_source} is {value_target:.2f} {currency_target}"
  )
  return LauncherActionDefinition(
    title=display,
    icon="emblem-synchronizing",
    action=lambda: utils.exec_sh(f'wl-copy "{value_target}"'),
  )


def currency_search(query) -> [LauncherActionDefinition]:
  rates = fetch_rates()

  default_value = 1
  default_source = "EUR"
  default_target = "RUB"

  split_query = query.split(",")

  value = convert_int(split_query[0], default_value)
  source = split_query[1].strip() if len(split_query) > 1 else default_source
  target = split_query[2].strip() if len(split_query) > 2 else default_target
  result = round((value / rates[source]) * rates[target], 2)

  return [map_currency_to_action(value, source, result, target)]


class LauncherModeCurrency(LauncherModeBase):
  def __init__(self):
    super().__init__(
      name="Currency converter",
      placeholder="Enter number, source and target currencies",
      trigger="cur:",
      search_function=currency_search,
    )
