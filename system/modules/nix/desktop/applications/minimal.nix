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
      hyprpolkitagent
      pinentry-gnome3

      grim
      slurp

      bluetui

      thunar-volman

      mate.engrampa
      # Supported archives
      zip
      gnutar
      rar
      p7zip
      unzip

      rhythmbox
      transmission_4-gtk

      element-desktop

      imv
      mpv

      pavucontrol
      qpwgraph

      caffeine-ng

      gparted
    ]
    ++ lib.optionals hasSecurity [
      kdePackages.kgpg
      seahorse
    ];

  services.tumbler.enable = true;

  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-archive-plugin
      thunar-vcs-plugin
      thunar-media-tags-plugin
    ];
  };
}
