{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.drakolis.desktop;

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
  environment.systemPackages =
    with pkgs;
    [
      grim

      bluetui

      pcmanfm-qt
      nemo

      lxqt.lxqt-archiver
      mate.engrampa
      # Supported archives
      zip
      gnutar
      rar
      p7zip
      unzip

      element-desktop

      imv
      mpv

      lxqt.qps
      lxqt.pavucontrol-qt
      qpwgraph

      caffeine-ng
    ]
    ++ lib.optionals hasSecurity [
      kdePackages.kgpg
    ];

}
