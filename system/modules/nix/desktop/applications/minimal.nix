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
      pinentry-gnome3

      grim
      slurp
      quota

      bluetui

      thunar-volman
      baobab

      mate.engrampa
      # Supported archives
      zip
      gnutar
      rar
      p7zip
      unzip

      gnome-maps

      decibels
      snapshot

      element-desktop

      imv
      mpv

      pavucontrol
      helvum
      qpwgraph

      caffeine-ng
    ]
    ++ lib.optionals hasAdvanced [
      gnome-characters
      textpieces
      dconf-editor
    ]
    ++ lib.optionals hasDownloads [
      transmission_4-gtk
    ]
    ++ lib.optionals hasEntertainment [
      aisleriot
      gnome-mahjongg
      gnome-mines
      gnome-sudoku
      gnome-2048
    ]
    ++ lib.optionals hasMedia [
      gnome-podcasts
      rhythmbox
      blanket
    ]
    ++ lib.optionals hasOffice [
      libreoffice
      geary
      evince
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
