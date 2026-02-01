from ignis import widgets
from ignis import utils
from ignis.services.mpris import MprisService, MprisPlayer


mpris = MprisService.get_default()


def mpris_title(player: MprisPlayer) -> widgets.Box:
  if (
    player.track_id != "/org/mpris/MediaPlayer2/firefox"
  ):  # Not needed since native host provides better info
    return widgets.EventBox(
      css_classes=["pill-button"],
      spacing=5,
      setup=lambda self: player.connect(
        "closed",
        lambda x: self.unparent(),  # remove widget when player is closed
      ),
      on_click=lambda _: player.play_pause(),
      on_right_click=lambda _: player.next(),
      child=[
        widgets.Icon(
          css_classes=["mpris-label", "label-bar"],
          image=player.bind(
            "playback_status",
            lambda status: "media-playback-playing-symbolic"
            if status == "Playing"
            else "media-playback-paused-symbolic",
          ),
        ),
        widgets.Label(
          css_classes=["mpris-label", "label-bar"],
          ellipsize="end",
          max_width_chars=30,
          label=player.bind_many(["title", "artist"], lambda t, a: f"{t} - {a}"),
        ),
      ],
    )


def mpris_status_widget() -> widgets.Box:
  return widgets.Box(
    css_classes=["bar-pill", "elevation1"],
    spacing=10,
    child=[
      widgets.Label(
        css_classes=["pill-button", "mpris-label", "label-bar"],
        label="No media players",
        visible=mpris.bind("players", lambda value: len(value) == 0),
      )
    ],
    setup=lambda self: mpris.connect(
      "player-added", lambda x, player: self.append(mpris_title(player))
    ),
  )
