{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.drakolis.desktop;
  cfgBolt = config.drakolis.thunderbolt;

  hasKde = builtins.elem "kde" cfg.types;
  hasAdvanced = builtins.elem "advanced" cfg.profiles;
  hasDownloads = builtins.elem "downloads" cfg.profiles;
  hasEntertainment = builtins.elem "entertainment" cfg.profiles;
  hasMedia = builtins.elem "media" cfg.profiles;
  hasOffice = builtins.elem "office" cfg.profiles;
  hasSecurity = builtins.elem "security" cfg.profiles;
  hasRemoteDesktop = builtins.elem "remoteDesktop" cfg.profiles;
  hasWork = builtins.elem "work" cfg.profiles;
in
with lib;
{
  config = mkIf (cfg.enable && hasKde) {
    environment.systemPackages =
      with pkgs;
      [
        kdePackages.falkon
        kdePackages.konversation
        kdePackages.krdc
        kdePackages.neochat

        haruna

        kdePackages.kate

        kdePackages.kolourpaint
        kdePackages.qrca

        kdePackages.filelight
        kdePackages.kfind
        quota

        qpwgraph

        kdePackages.kcalc
        kdePackages.kcharselect
        kdePackages.kcolorchooser
        kdePackages.sweeper
        crow-translate
      ]
      ++ lib.optionals hasAdvanced [
        kdePackages.yakuake
        kdePackages.kompare
        krename
      ]
      ++ lib.optionals hasDownloads [
        kdePackages.kget
        kdePackages.ktorrent
      ]
      ++ lib.optionals hasEntertainment [
        kdePackages.kmahjongg
        kdePackages.kpat
        kdePackages.knights
        kdePackages.kbreakout
        kdePackages.minuet
      ]
      ++ lib.optionals hasMedia [
        kdePackages.kasts
        kid3
      ]
      ++ lib.optionals hasOffice [
        kdePackages.akregator
        kdePackages.kdepim-addons
      ]
      ++ lib.optionals hasSecurity [
        kdePackages.kleopatra
      ]
      ++ lib.optionals hasRemoteDesktop [
        kdePackages.krfb
      ]
      ++ lib.optionals true [ # TODO: Add a variable for Thunderbolt
        kdePackages.plasma-thunderbolt
      ];

    programs.kdeconnect.enable = true;
    programs.kclock.enable = false;
    programs.kde-pim.enable = true;
    programs.kde-pim.kmail = true;
    programs.kde-pim.kontact = false;
    programs.kde-pim.merkuro = true;

    nixpkgs.config.permittedInsecurePackages = [
      "olm-3.2.16"
    ];
  };
}
