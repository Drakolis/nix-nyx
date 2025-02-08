{ config, lib, pkgs, ... }:

let
  style = import ./constants/style.nix;
  commands = import ./constants/commands.nix;
  paths = import ./constants/paths.nix;
in {
  imports = [
    ./modules/shell
    ./modules/neovim
    ./modules/yazi
    ./modules/office.nix
    # Linux specific
    ./modules/hypr
    ./modules/desktop
    ./modules/dashboards/glance.nix
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
  home.packages = with pkgs; [
    # Shell
    navi
    starship
    zoxide
    zellij

    # Terminal utilities
    asdf-vm
    exiftool
    pet
    sunwait
    taskwarrior3
    tealdeer
    tgpt
    topgrade
    translate-shell

    # Docker
    docker
    docker-compose
    colima

    # Terminal fanciness
    cava
    lolcat
    hyfetch

    # TUI Utilities
    bluetui
    gitui
    himalaya
    iamb # Matrix TUI
    khal
    khard
    ledger
    neomutt
    taskwarrior-tui

    # TUI fanciness
    cava

    # Libraries

    # Linux services
    batsignal
    # cliphist
    # comodoro
    vdirsyncer
    rclone

    # GUI Services
    activitywatch
    caffeine-ng
    glance

    # NixOS Specific
    dconf2nix

    # Desktop Helpers
    avizo
    swaynotificationcenter
    walker
    waybar
    wlogout

    # GUI Apps: Office
    libreoffice-qt6
    logseq
    thunderbird
    zathura # pdf view
    qalculate-gtk

    # GUI Apps: Dev
    beekeeper-studio
    bruno
    ghostty
    hoppscotch
    jetbrains.idea-community-bin
    krita
    vscodium
    wireshark-qt

    # GUI Apps: Internet
    element-desktop
    networkmanagerapplet
    signal-desktop
    transmission_4-qt6

    # GUI Apps: Media
    lollypop
    mpv
    rhythmbox
    xfce.parole

    # GUI Apps: Creativity
    blender
    inkscape-with-extensions
    obs-studio
    swappy

    # GUI Apps: Games
    dosbox
    mangohud

    # GUI Apps: Security
    cryptomator
    keepassxc

    # GUI Apps: System
    qt6Packages.qt6ct
    qt6Packages.qtstyleplugin-kvantum
    easyeffects
    helvum
    pavucontrol

    # Theming
    (catppuccin-kde.override {
      accents = [ "mauve" ];
      flavour = [ "mocha" ];
    })
    (catppuccin-kvantum.override {
      accent = "mauve";
      variant = "mocha";
    })
    (catppuccin-gtk.override {
      accents = [ "mauve" ];
      variant = "mocha";
    })
    catppuccin-papirus-folders
    catppuccinifier-cli
    catppuccin-whiskers
    catppuccin-cursors.mochaDark

    # Fonts
    nerd-fonts.ubuntu
    nerd-fonts.ubuntu-mono
    nerd-fonts.open-dyslexic

    # Scripts: wttr
    (writeShellScriptBin "wttr" ''
      curl wttr.in/$1
    '')
  ];

  nixpkgs.config.permittedInsecurePackages = [ "electron-27.3.11" ];

  home.keyboard = null;

  home.file = {
    # This should be fixed in https://github.com/NixOS/nixpkgs/issues/355277
    ".config/Kvantum/catppuccin-mocha-mauve".source = "${
        (pkgs.catppuccin-kvantum.override {
          accent = "mauve";
          variant = "mocha";
        })
      }/share/Kvantum/catppuccin-mocha-mauve";

    ".config/keepassxc/keepassxc.ini" = {
      enable =
        false; # TODO: Find a way to only create this when there is no file
      text = ''
        [General]
        ConfigVersion=2

        [GUI]
        ApplicationTheme=darkv
        MinimizeOnClose=true
        MinimizeOnStartup=true
        ShowTrayIcon=true
        TrayIconAppearance=monochrome-dark
      '';
    };
  };

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
    TERMINAL = commands.terminal;
    # GTK_USE_PORTAL = 1;
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_STYLE_OVERRIDE = "kvantum";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.pointerCursor = {
    package =
      pkgs.catppuccin-cursors.mochaDark; # For some reason this is mandatory to repeat here
    name = style.cursorTheme.name + 10;
    size = style.cursorTheme.size;
    hyprcursor = { enable = true; }; # Here because of hyprcursor
  };

  gtk = {
    enable = true;
    cursorTheme = {
      name = style.cursorTheme.name;
      size = style.cursorTheme.size;
    };
    font = {
      name = style.fontGui;
      size = style.fontSize;
    };
    iconTheme = { name = style.iconTheme.name; };
    theme = { name = "catppuccin-mocha-mauve-standard"; };
    gtk3.extraConfig = {
      gtk-menu-images = 1;
      gtk-button-images = 0;
    };
  };

  qt = {
    enable = true;
    platformTheme = { name = "qtct"; };
    style = { name = "kvantum"; };
  };

  xdg = {
    enable = true;
    autostart.enable = false;
    portal = {
      enable = true;
      config = {
        common = {
          default = "hyprland";
          "org.freedesktop.impl.portal.Settings" = "gtk";
        };
      };
    };
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = paths.desktop;
      documents = paths.documents;
      download = paths.download;
      music = paths.music;
      pictures = paths.pictures;
      publicShare = paths.publicShare;
      templates = paths.templates;
      videos = paths.videos;
    };
  };

  programs.hyfetch = {
    enable = true;
    settings = {
      preset = "transgender";
      mode = "rgb";
      light_dark = "dark";
      lightness = 0.65;
      color_align = {
        mode = "horizontal";
        custom_colors = [ ];
        fore_back = null;
      };
      backend = "neofetch";
      args = null;
      distro = null;
      pride_month_shown = [ ];
      pride_month_disable = false;
    };
  };

  programs.git = {
    enable = true;
    userEmail = "mika.drakolis@gmail.com";
    userName = "Mika Drakolis";
    extraConfig = { init = { defaultBranch = "main"; }; };
  };

  programs.gitui = {
    enable = true;
    theme = ''
      (
        selected_tab: Some("Reset"),
        command_fg: Some("#${style.colors.textInverted}"),
        selection_bg: Some("#${style.colors.selection}"),
        selection_fg: Some("#${style.colors.textInverted}"),
        cmdbar_bg: Some("#${style.colors.primary}"),
        cmdbar_extra_lines_bg: Some("#${style.colors.primary}"),
        disabled_fg: Some("#${style.colors.textGray}"),
        diff_line_add: Some("#${style.colors.gitAdded}"),
        diff_line_delete: Some("#${style.colors.gitRemoved}"),
        diff_file_added: Some("#${style.colors.gitAdded}"),
        diff_file_removed: Some("#${style.colors.gitRemoved}"),
        diff_file_moved: Some("#${style.colors.gitMoved}"),
        diff_file_modified: Some("#${style.colors.gitModified}"),
        commit_hash: Some("#${style.colors.gitCommit}"),
        commit_time: Some("#${style.colors.gitTime}"),
        commit_author: Some("#${style.colors.gitAuthor}"),
        danger_fg: Some("#${style.colors.error}"),
        push_gauge_bg: Some("#${style.colors.primary}"),
        push_gauge_fg: Some("#${style.colors.textInverted}"),
        tag_fg: Some("#${style.colors.gitTag}"),
        branch_fg: Some("#${style.colors.gitBranch}"),
      )
    '';
  };

  programs.bat = {
    enable = true;
    config = { theme = "Catppuccin Mocha"; };
    themes = {
      "Catppuccin Mocha" = {
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "699f60fc8ec434574ca7451b444b880430319941";
          sha256 = "6fWoCH90IGumAMc4buLRWL0N61op+AuMNN9CAR9/OdI=";
        };
        file = "themes/Catppuccin Mocha.tmTheme";
      };
    };
  };

  programs.pet = {
    enable = true;
    settings = {
      General = {
        editor = commands.tui.editor;
        column = 40;
        selectcmd = "fzf"; # TODO: Move this out
        backend = "gitlab";
        sortby = "recency";
        cmd = [ "sh" "-c" ];
        color = true;
        format = "[$description: $command]";
      };
      GitLab = {
        url = "https://gitlab.com";
        file_name = "snippet.toml";
        access_token = ""; # TODO: Replace this before comitting
        id = "4800544";
        visability = "private";
        auto_sync = true;
      };
    };
  };

  programs.tealdeer = {
    enable = true;
    settings = {
      display = { use_pager = true; };
      style = {
        description = { };
        example_text = { foreground = "blue"; };
        command_name = { foreground = "green"; };
        example_code = { };
        example_variable = {
          foreground = "cyan";
          underline = true;
        };
      };
      updates = { auto_update = true; };
    };
  };

  programs.bottom = {
    enable = true;
    settings = {
      flags = { battery = true; };
      styles = {
        widgets = {
          widget_title = {
            color = "#${style.colors.secondary}";
            bold = true;
          };
          border_color = "#${style.colors.tableLine}";
          selected_border_color = "#${style.colors.primary}";
          text = { color = "#${style.colors.text}"; };
          selected_text = {
            color = "#${style.colors.textInverted}";
            bg_color = "#${style.colors.selection}";
          };
        };
        tables = { headers = { color = "#${style.colors.highlight}"; }; };
        battery = {
          high_battery_color = "#${style.colors.success}";
          medium_battery_color = "#${style.colors.warning}";
          low_battery_color = "#${style.colors.error}";
        };
        graphs = {
          graph_color = "#${style.colors.textDark}";
          legend_text = { color = "#${style.colors.textDark}"; };
        };
        network = {
          rx_color = "#${style.colors.success}";
          tx_color = "#${style.colors.error}";
        };
        cpu = {
          all_entry_color = "#${style.colors.success}";
          avg_entry_color = "#${style.colors.error}";
          cpu_core_colors = [
            "light magenta"
            "light yellow"
            "light cyan"
            "light green"
            "light blue"
            "cyan"
            "green"
            "blue"
          ];
        };
        memory = {
          ram_color =
            "#${style.colors.path}"; # This may be illogical, just uses shades of blue really
          swap_color = "#${style.colors.info}";
          gpu_colors = [ "magenta" ]; # ?????
          arc_color = "#${style.colors.highlight}";
        };
      };
    };
  };

  programs.cava = {
    enable = true;
    settings = { };
  };

  programs.ledger = { enable = true; };

  programs.translate-shell = {
    enable = true;
    settings = {
      hl = "en";
      tl = "de";
      verbose = false;
    };
  };

  programs.topgrade = {
    enable = true;
    settings = {
      misc = {
        assume_yes = true;
        disable = [ "docker" "clamav" ];
        set_title = false;
        cleanup = true;
      };
      commands = {
        "Run garbage collection on Nix store" = "nix-collect-garbage";
      };
    };
  };

  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = {
      theme = "drakolis";
      font-family = style.fontMonospace;
      font-size = style.fontSize;

      shell-integration-features = "no-cursor";
      cursor-style = "block";

      gtk-titlebar = true;
      gtk-adwaita = false;
      window-theme = "ghostty";
      confirm-close-surface = false;

      window-decoration = "auto";
      macos-titlebar-style = "tabs";
      macos-option-as-alt = true;
      macos-icon = "custom-style";
      macos-icon-ghost-color = style.colors.primary;
      macos-icon-screen-color = style.colors.background;

      keybind = [
        "ctrl+alt+up=new_split:up"
        "ctrl+alt+down=new_split:down"
        "ctrl+alt+left=new_split:left"
        "ctrl+alt+right=new_split:right"
        "alt+shift+up=goto_split:top"
        "alt+shift+down=goto_split:bottom"
        "alt+shift+left=goto_split:left"
        "alt+shift+right=goto_split:right"
        "ctrl+alt+e=equalize_splits"
        "ctrl+tab=next_tab"
        "ctrl+shift+tab=previous_tab"
        "ctrl+shift+grave_accent=toggle_tab_overview"
      ];
    };
    themes = {
      drakolis = {
        background = style.colors.background;
        background-opacity = 0.97;
        cursor-color = style.colors.primary;
        foreground = style.colors.text;
        palette = [
          "0=#${style.colors.terminalBlack}"
          "1=#${style.colors.terminalRed}"
          "2=#${style.colors.terminalGreen}"
          "3=#${style.colors.terminalYellow}"
          "4=#${style.colors.terminalBlue}"
          "5=#${style.colors.terminalMagenta}"
          "6=#${style.colors.terminalCyan}"
          "7=#${style.colors.terminalGray}"
          "8=#${style.colors.terminalBlack2}"
          "9=#${style.colors.terminalRed2}"
          "10=#${style.colors.terminalGreen2}"
          "11=#${style.colors.terminalYellow2}"
          "12=#${style.colors.terminalBlue2}"
          "13=#${style.colors.terminalMagenta2}"
          "14=#${style.colors.terminalCyan2}"
          "15=#${style.colors.terminalGray2}"
        ];
        selection-background = style.colors.secondary;
        selection-foreground = style.colors.textInverted;
      };
    };

  };

  programs.kitty = {
    enable = true;
    font = {
      name = style.fontMonospace;
      size = style.fontSize;
    };
    shellIntegration = {
      enableBashIntegration = true;
      enableZshIntegration = true;
      mode = "no-cursor";
    };
    themeFile = "Catppuccin-Mocha";
    keybindings = {
      "ctrl+shift+a>1" = "set_background_opacity 1";
      "ctrl+shift+a>0" = "set_background_opacity 0";
      "ctrl+shift+a>d" = "set_background_opacity default";
    };
    settings = {
      cursor_shape = "block";
      cursor_shape_unfocused = "hollow";
      cursor_trail = 0;
      show_hyperlink_targets = "yes";
      paste_actions =
        "quote-urls-at-prompt,replace-newline,confirm,confirm-if-large";
      strip_trailing_spaces = "smart";
      focus_follows_mouse = "yes"; # TODO: Test this out

      enable_audio_bell = "no";
      visual_bell_duration = 0.5;
      visual_bell_color = "#${style.colors.panel}";
      bell_on_tab = "󰂚";

      window_border_width = 0;
      window_padding_width = "5 5 0";

      tab_bar_edge = "bottom";
      tab_bar_margin_height = "2 2";
      tab_bar_style = "powerline";
      tab_powerline_style = "round";
      tab_activity_symbol = "󰞌";
      tab_title_template =
        "{fmt.fg.tab}{index}: {title} {fmt.fg.red}{bell_symbol}{activity_symbol}";

      notify_on_cmd_finish = "invisible";

      wayland_titlebar_color = "background";
      macos_titlebar_color = "background";
      macos_option_as_alt = "yes";
      macos_colorspace = "displayp3";

      # Colors:
      cursor = "#${style.colors.primary}";
      cursor_text_color = "#${style.colors.textInverted}";
      url_color = "#${style.colors.path}";
      active_border_color = "#${style.colors.primary}";
      inactive_border_color = "#${style.colors.shadow}";
      bell_border_color = "#${style.colors.error}";
      active_tab_foreground = "#${style.colors.textInverted}";
      active_tab_background = "#${style.colors.primary}";
      active_tab_font_style = "bold";
      inactive_tab_foreground = "#${style.colors.textGray}";
      inactive_tab_background = "#${style.colors.activeSurface}";
      inactive_tab_font_style = "bold";
      tab_bar_background = "#${style.colors.panel}";
      tab_bar_margin_color = "#${style.colors.panel}";

      foreground = "#${style.colors.text}";
      background = "#${style.colors.background}";
      selection_foreground = "#${style.colors.textInverted}";
      selection_background = "#${style.colors.secondary}";
      background_opacity = 0.97;
      dynamic_background_opacity = true;
      color0 = "#${style.colors.terminalBlack}";
      color1 = "#${style.colors.terminalRed}";
      color2 = "#${style.colors.terminalGreen}";
      color3 = "#${style.colors.terminalYellow}";
      color4 = "#${style.colors.terminalBlue}";
      color5 = "#${style.colors.terminalMagenta}";
      color6 = "#${style.colors.terminalCyan}";
      color7 = "#${style.colors.terminalGray}";
      color8 = "#${style.colors.terminalBlack2}";
      color9 = "#${style.colors.terminalRed2}";
      color10 = "#${style.colors.terminalGreen2}";
      color11 = "#${style.colors.terminalYellow2}";
      color12 = "#${style.colors.terminalBlue2}";
      color13 = "#${style.colors.terminalMagenta2}";
      color14 = "#${style.colors.terminalCyan2}";
      color15 = "#${style.colors.terminalGray2}";
    };
  };

  programs.imv = {
    enable = true;
    settings = {
      options = {
        background = "${style.colors.background}";
        overlay_text_color = "${style.colors.text}";
        overlay_background_color = "${style.colors.shadow}";
      };
    };
  };

  programs.firefox = {
    enable = true;
    languagePacks = [ "en-GB" ];
    policies = {
      DisableAppUpdate = true; # Managed by Nix
      DisableSetDesktopBackground = true; # Managed by Nix
      PasswordManagerEnabled = false;
      AutofillCreditCardEnabled = false;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      EncryptedMediaExtensions = {
        Enabled = false;
        Locked = false;
      };
      FirefoxHome = {
        Search = true;
        TopSites = true;
        SponsoredTopSites = true;
        Snippets = true;
        Highlights = true;
      };
      SanitizeOnShutdown = { Cache = true; };
      HttpsOnlyMode = "force_enabled";
      Bookmarks = [
        {
          Title = "Nix";
          URL = "https://nixos.org/";
          Favicon = "https://nixos.org/favicon.ico";
          Placement = "menu";
          Folder = "NixOS";
        }
        {
          Title = "NixOS Manual";
          URL = "https://nix.dev/manual/nix/2.24/introduction";
          Favicon = "https://nixos.org/favicon.ico";
          Placement = "menu";
          Folder = "NixOS";
        }
        {
          Title = "NixOS Wiki";
          URL = "https://example.com";
          Favicon = "https://nixos.org/favicon.ico";
          Placement = "menu";
          Folder = "NixOS";
        }
        {
          Title = "NixOS Search - Packages";
          URL = "https://search.nixos.org/packages";
          Favicon = "https://nixos.org/favicon.ico";
          Placement = "menu";
          Folder = "NixOS";
        }
        {
          Title = "NixOS Search - Options";
          URL = "https://search.nixos.org/options";
          Favicon = "https://nixos.org/favicon.ico";
          Placement = "menu";
          Folder = "NixOS";
        }
        {
          Title = "MyNixOS - Flakes";
          URL = "https://mynixos.com/flakes";
          Favicon = "https://nixos.org/favicon.ico";
          Placement = "menu";
          Folder = "NixOS";
        }
        {
          Title = "MyNixOS - Packages";
          URL = "https://mynixos.com/packages";
          Favicon = "https://nixos.org/favicon.ico";
          Placement = "menu";
          Folder = "NixOS";
        }
        {
          Title = "MyNixOS - Options";
          URL = "https://mynixos.com/options";
          Favicon = "https://nixos.org/favicon.ico";
          Placement = "menu";
          Folder = "NixOS";
        }
        {
          Title = "Home Manager - Options";
          URL = "https://nix-community.github.io/home-manager/options.xhtml";
          Favicon = "https://nixos.org/favicon.ico";
          Placement = "menu";
          Folder = "NixOS";
        }
      ];
    };
  };

  # programs.thunderbird = { enable = true; };

  # services.cliphist = {
  #   enable = true;
  #   allowImages = true;
  #   extraOptions =
  #     [ "-max-dedupe-search" "10" "-max-items" "500" "-preview-width" "100" ];
  # };

  services.swaync.enable = true;

  services.caffeine.enable = true;

  services.activitywatch.enable = true;

  services.avizo.enable = true;

  services.batsignal.enable = true;

  systemd.user.services.schedule = {
    Unit = { Description = "Schedule Script"; };
    Service = {
      ExecStart = "/home/drakolis/.config/home-manager/scripts/schedule.sh";
      Type = "simple";
    };
    Install = { WantedBy = [ "default.target" ]; };
  };

  systemd.user.services.walker = {
    Unit = { Description = "Walker GApplication"; };
    Service = {
      ExecStart =
        "/home/drakolis/.nix-profile/bin/walker --gapplication-service";
      Type = "simple";
      Restart = "on-failure";
    };
    Install = { WantedBy = [ "default.target" ]; };
  };

  systemd.user.timers.schedule = {
    Unit = { Description = "Run the schedule every 10 minutes"; };
    Timer = {
      OnCalendar = "*:0/10"; # Every 10 minutes
      Persistent = true;
    };
    Install = { WantedBy = [ "timers.target" ]; };
  };
}
