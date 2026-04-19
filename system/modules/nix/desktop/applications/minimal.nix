{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.drakolis.desktop;

  hasNiri = builtins.elem "niri" cfg.types;
  hasHyprland = builtins.elem "hyprland" cfg.types;
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
  config = mkIf (cfg.enable && (hasNiri || hasHyprland)) {
    services.udisks2.enable = true;
    environment.systemPackages =
      with pkgs;
      [
        pinentry-gnome3

        grim
        slurp
        quota

        bluetui

        nautilus
        baobab

        file-roller
        # Supported archives
        zip
        gnutar
        rar
        p7zip
        unzip

        gnome-maps

        snapshot

        element-desktop

        mpv

        pwvucontrol
        crosspipe
        # qpwgraph

        caffeine-ng

        gnome-characters
      ]
      ++ lib.optionals hasAdvanced [
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
        geary
        evince
      ]
      ++ lib.optionals hasSecurity [
        # kdePackages.kgpg
        seahorse
      ];

    security.soteria.enable = true;
    services.tumbler.enable = true;

    programs.imv.settings = {
      enable = true;
      settings = {
        options.background = "1e1e2e";
        options.overlay_text_color = "cdd6f4";
        options.overlay_background_color = "11111b";
      };
    };

    programs.kdeconnect = {
      enable = true;
      package = pkgs.valent;
    };

    programs.thunar = {
      enable = true;
      plugins = with pkgs; [
        thunar-archive-plugin
        thunar-vcs-plugin
        thunar-media-tags-plugin
      ];
    };
  };
}
