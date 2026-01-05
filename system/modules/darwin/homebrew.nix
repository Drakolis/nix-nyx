{
  config,
  lib,
  ...
}:
let
  cfg = config.drakolis.desktop;

  desktopProfiles = lib.types.enum [
    "advanced"
    "downloads"
    "media"
    "office"
    "security"
    "remoteDesktop"
    "work"
  ];

  hasAdvanced = builtins.elem "advanced" cfg.profiles;
  hasDownloads = builtins.elem "downloads" cfg.profiles;
  hasMedia = builtins.elem "media" cfg.profiles;
  hasOffice = builtins.elem "office" cfg.profiles;
  hasSecurity = builtins.elem "security" cfg.profiles;
  hasRemoteDesktop = builtins.elem "remoteDesktop" cfg.profiles;
  hasWork = builtins.elem "work" cfg.profiles;

in
with lib;
{
  options = {
    drakolis.desktop = {
      profiles = mkOption {
        default = [ ];
        type = types.listOf desktopProfiles;
        description = ''
          Select the profiles (lists of apps) to install.
        '';
      };
    };
  };

  config = {
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
        "proton-pass"
        "proton-drive"
        # "micro-snitch"
        # "little-snitch"

        # other:
        "domzilla-caffeine"

        "hammerspoon"
        "vial"
      ]
      # Profile: Advanced
      ++ lib.optionals hasAdvanced [
        "cryptomator"
        "balenaetcher"
      ]
      # Profile: Media
      ++ lib.optionals hasMedia [
        "vlc"
        "krita"
      ]
      # Profile: Work
      ++ lib.optionals hasWork [
        "1password"
      ];
    };
  };
}
