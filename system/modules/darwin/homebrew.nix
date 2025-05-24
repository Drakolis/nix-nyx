{ pkgs, ... }:
{
  homebrew = {
    enable = true;
    casks = [
      # dev:
      "beekeeper-studio"

      # inet:
      "proton-mail"
      "protonvpn"
      "slack"
      "zoom"
      "element"

      # security:
      "1password" # Work only?
      "proton-pass"
      "cryptomator"
      "proton-drive"
      # "micro-snitch"
      # "little-snitch"

      # media:
      "vlc"
      "krita"

      # other:
      "vial"
      "caffeine"
      "balenaetcher"
    ];
  };
}
