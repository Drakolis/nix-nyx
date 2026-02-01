import requests
from ignis import utils

from ._base import LauncherActionDefinition, LauncherModeBase

API_URL = "https://open.er-api.com/v6/latest/USD"


def fetch_rates():
  response = requests.get(API_URL)
  response.raise_for_status()
  data = response.json()
  rates = data["rates"]
  return rates


def map_currency_to_action(number, target_currency):
  return LauncherActionDefinition(
    title=f"{number}, {target_currency}",
    icon="emblem-synchronizing",
    action=lambda: utils.exec_sh(f'wl-copy "{number}"'),
  )


def currency_search(query) -> [LauncherActionDefinition]:
  rates = fetch_rates()
  brl_per_usd = rates["BRL"], "BRL"
  eur_per_usd = rates["EUR"], "EUR"
  rub_per_usd = rates["RUB"], "RUB"

  return [
    map_currency_to_action(value[0], value[1])
    for value in [brl_per_usd, eur_per_usd, rub_per_usd]
  ]


class LauncherModeCurrency(LauncherModeBase):
  def __init__(self):
    super().__init__(
      name="Currency converter",
      placeholder="Enter number, source and target currencies",
      trigger="cur:",
      search_function=currency_search,
    )
