{ pkgs, ... }:
{
  homebrew = {
    enable = true;
    casks = [
      # dev:
      "beekeeper-studio"

      # inet:
      "slack"
      "zoom"

      # security:
      "proton-pass"
      "protonvpn"

      # media:
      "vlc"
      "krita"

      # other:
      "vial"
      "caffeine"
    ];
  };
}
