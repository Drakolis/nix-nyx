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

      # security:
      "1password"
      "proton-pass"
      "cryptomator"
      "proton-drive"

      # media:
      "vlc"
      "krita"

      # other:
      "vial"
      "caffeine"
    ];
  };
}
