{ config, lib, pkgs, ... }:

let
  style = import ./constants/style.nix;
  commands = import ./constants/commands.nix;
  paths = import ./constants/paths.nix;
in {
  imports = [
    #     ./modules/office.nix
    # If using Hyprland
    #     ./modules/hypr
    #     ./modules/desktop
    #     ./modules/dashboards/glance.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "drakolis";
  home.homeDirectory = "/home/drakolis";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs;
    [

      # Terminal fanciness

      # TUI Utilities
      #     bluetui
      #     himalaya
      #     iamb # Matrix TUI
      #     khal
      #     khard
      #     ledger
      #     neomutt
      #     taskwarrior-tui

      # Libraries

      # Linux services
      #     batsignal
      #     cliphist
      #     comodoro

      # GUI Services
      #     activitywatch
      #
      #     glance

      # NixOS Specific
      dconf2nix

      # Desktop Helpers
      #     swaynotificationcenter
      #     walker
      #     waybar
      #     wlogout

      # GUI Apps: Office
      #     libreoffice-qt6

      #     thunderbird
      #     zathura # pdf view

      # GUI Apps: Dev

      # GUI Apps: Internet
      #     element-desktop
      #     networkmanagerapplet

      #     transmission_4-qt6
      #     brave

      # GUI Apps: Media
      #     mpv
      #     vlc

      # GUI Apps: Creativity
      #

      #

      # GUI Apps: Games
      #     gamescope

      # GUI Apps: Security

      # GUI Apps: System
      #     easyeffects
      #     lxqt.pavucontrol-qt

      # Theming

      # Fonts

      # Scripts: wttr

    ];

  nixpkgs.config.permittedInsecurePackages = [ "electron-27.3.11" ];

  home.keyboard = null;

  #   home.file = {
  #     # This should be fixed in https://github.com/NixOS/nixpkgs/issues/355277
  #     ".config/Kvantum/catppuccin-mocha-mauve".source = "${
  #         (pkgs.catppuccin-kvantum.override {
  #           accent = "mauve";
  #           variant = "mocha";
  #         })
  #       }/share/Kvantum/catppuccin-mocha-mauve";
  #
  #     ".config/keepassxc/keepassxc.ini" = {
  #       enable =
  #         false; # TODO: Find a way to only create this when there is no file
  #       text = ''
  #         [General]
  #         ConfigVersion=2
  #
  #         [GUI]
  #         ApplicationTheme=darkv
  #         MinimizeOnClose=true
  #         MinimizeOnStartup=true
  #         ShowTrayIcon=true
  #         TrayIconAppearance=monochrome-dark
  #       '';
  #     };
  #   };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/drakolis/etc/profile.d/hm-session-vars.sh
  #

  home.sessionVariables = {
    # XCURSOR_SIZE = 24;
    # HYPRCURSOR_SIZE = 32;
    EDITOR = commands.tui.editor;
    #     TERMINAL = commands.terminal;
    #     QT_QPA_PLATFORMTHEME = "qt5ct";
    # QT_STYLE_OVERRIDE = "kvantum";
    #     GDK_BACKEND = "wayland";
  };

  #
  #   xdg = {
  #     enable = true;
  #     autostart.enable = false;
  #     portal = {
  #       enable = true;
  #       config = {
  #         common = {
  #           default = "hyprland";
  #           "org.freedesktop.impl.portal.FileChooser" = "kde";
  #         };
  #       };
  #     };
  #     userDirs = {
  #       enable = true;
  #       createDirectories = true;
  #       desktop = paths.desktop;
  #       documents = paths.documents;
  #       download = paths.download;
  #       music = paths.music;
  #       pictures = paths.pictures;
  #       publicShare = paths.publicShare;
  #       templates = paths.templates;
  #       videos = paths.videos;
  #     };
  #   };

  #   programs.ledger = { enable = true; };

  #   programs.topgrade = {
  #     enable = true;
  #     settings = {
  #       misc = {
  #         assume_yes = true;
  #         disable = [ "docker" "clamav" ];
  #         set_title = false;
  #         cleanup = true;
  #       };
  #       commands = {
  #         "Run garbage collection on Nix store" = "nix-collect-garbage";
  #       };
  #     };
  #   };

  #   programs.imv = {
  #     enable = true;
  #     settings = {
  #       options = {
  #         background = "${style.colors.background}";
  #         overlay_text_color = "${style.colors.text}";
  #         overlay_background_color = "${style.colors.shadow}";
  #       };
  #     };
  #   };

  # programs.thunderbird = { enable = true; };

  # services.cliphist = {
  #   enable = true;
  #   allowImages = true;
  #   extraOptions =
  #     [ "-max-dedupe-search" "10" "-max-items" "500" "-preview-width" "100" ];
  # };

  #   services.caffeine.enable = true;

  #   services.activitywatch.enable = true;

  #   services.batsignal.enable = true;

  #   systemd.user.services.schedule = {
  #     Unit = { Description = "Schedule Script"; };
  #     Service = {
  #       ExecStart = "/home/drakolis/.config/home-manager/scripts/schedule.sh";
  #       Type = "simple";
  #     };
  #     Install = { WantedBy = [ "default.target" ]; };
  #   };
  #
  #
  #   systemd.user.timers.schedule = {
  #     Unit = { Description = "Run the schedule every 10 minutes"; };
  #     Timer = {
  #       OnCalendar = "*:0/10"; # Every 10 minutes
  #       Persistent = true;
  #     };
  #     Install = { WantedBy = [ "timers.target" ]; };
  #   };
}
