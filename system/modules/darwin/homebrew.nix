{ pkgs, ... }:
{
  homebrew = {
    enable = true;
    casks = [
      # dev:
      "beekeeper-studio"

      # inet:
      "librewolf"
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
    ];
  };
}

# Has package in Nix
# dev:
# hoppscotch
# dbeaver-bin
# iterm2
# vscodium

# inet:
# element
# proton-mail

# security:
# _1password-gui
# keepassxc
# protonvpn

# other:
# maccy
# numi
