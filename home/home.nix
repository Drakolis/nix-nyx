{ config, pkgs, ... }:

let
  style = import ./variables/style.nix;
  commands = import ./variables/commands.nix;
  previewTextInFzf = "bat --style=numbers --color=always --line-range :500 {}";

in {
  imports = [ ./modules/hyprland.nix ];
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
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    pkgs.starship
    pkgs.asdf
    pkgs.hyfetch

    pkgs.dconf2nix

    pkgs.cava
    pkgs.navi

    pkgs.iamb
    pkgs.dooit
    pkgs.khal
    pkgs.khard

    pkgs.himalaya
    pkgs.aerc
    pkgs.mutt
    pkgs.alpine

    # pkgs.feh
    pkgs.element-desktop
    pkgs.keepassxc
    pkgs.krita
    pkgs.ghostty

    # Theming
    (pkgs.catppuccin-kvantum.override {
      accent = "mauve";
      variant = "mocha";
    })
    (pkgs.catppuccin-gtk.override {
      accents = [ "mauve" ];
      variant = "mocha";
    })
    pkgs.catppuccin-papirus-folders
    pkgs.catppuccinifier-cli
    pkgs.catppuccin-whiskers
    pkgs.catppuccin-cursors.mochaDark

    pkgs.nerd-fonts.ubuntu
    pkgs.nerd-fonts.ubuntu-mono
    pkgs.nerd-fonts.meslo-lg
    pkgs.nerd-fonts.open-dyslexic

    pkgs.vscodium
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "MesloLG" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command1 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    (pkgs.writeShellScriptBin "wttr" ''
      curl wttr.in/$1
    '')
    (pkgs.writeShellScriptBin "previewScreenshot" ''
      ${commands.previewImage} -w Screenshot $1
    '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".config/dooit/config.py".text = ''
      from dooit.api.theme import DooitThemeBase
      from dooit.ui.api import DooitAPI, subscribe
      from dooit.ui.api.events import Startup

      class Drakolis(DooitThemeBase):
        _name = "dooit-drakolis"

        background1: str = "#${style.colors.background}"  # Darkest
        background2: str = "#${style.colors.error}"  # Lighter
        background3: str = "#${style.colors.warning}"  # Lightest

        # foreground colors
        foreground1: str = "#${style.colors.selection}"  # Darkest
        foreground2: str = "#${style.colors.locked}"  # Lighter
        foreground3: str = "#${style.colors.text}"  # Lightest

        # other colors
        red: str = "#BF616A"
        orange: str = "#D08770"
        yellow: str = "#EBCB8B"
        green: str = "#A3BE8C"
        blue: str = "#81a1c1"
        purple: str = "#B48EAD"
        magenta: str = "#B48EAD"
        cyan: str = "#8fbcbb"

        # accent colors
        primary: str = "#${style.colors.primary}"
        secondary: str = "#${style.colors.highlight}"

      @subscribe(Startup)
      def layout_setup(api: DooitAPI, _):
        api.css.set_theme(Drakolis)
    '';

    ".config/yofi/yofi.config".text = ''
      width = 500
      height = 512

      font = "${style.fontGui}"
      font_size = ${toString (style.fontSize * 2)}

      bg_color = 0x${style.colors.background}ff
      font_color = 0x${style.colors.text}ff
      bg_border_color = 0x${style.colors.primary}ff
      bg_border_width = ${toString style.border.outer.width}
      corner_radius = "${toString style.border.outer.radius}"
      # scale = 3

      term = "${commands.terminal}"

      [input_text]
      font_color = 0x${style.colors.text}ff
      bg_color = 0x${style.colors.activeSurface}ff
      corner_radius = "${toString style.border.inner.radius}"
      margin = "5"
      padding = "1.7 -4"

      [list_items]
      font_color = 0x${style.colors.text}ff
      selected_font_color = 0x${style.colors.primary}ff
      match_color = 0x${style.colors.highlight}ff
      margin = "5 10"
      hide_actions = false
      action_left_margin = 60
      item_spacing = 2
      icon_spacing = 5

      [icon]
      size = ${toString style.iconTheme.size}
      theme = "${style.iconTheme.name}"
      fallback_icon_path = "/usr/share/icons/Adwaita/symbolic/categories/applications-engineering-symbolic.svg"
    '';
  };

  home.keyboard = null;

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
    TERM = commands.terminal;
    QT_QPA_PLATFORMTHEME = "qt5ct";
    # QT_STYLE_OVERRIDE = "kvantum";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  gtk = {
    enable = true;
    cursorTheme = {
      name = style.cursorTheme.name;
      #   size = style.cursorTheme.size;
    };
    font = {
      name = style.fontGui;
      size = style.fontSize;
    };
    iconTheme = { name = style.iconTheme.name; };
    theme = { name = "catppuccin-mocha-mauve-standard"; };
  };

  # qt = {
  #   enable = true;
  #   platformTheme = {
  #     name = "qtct";
  #   };
  #   style = {
  #     name = "kvantum";
  #   };
  # };

  home.pointerCursor = {
    package =
      pkgs.catppuccin-cursors.mochaDark; # For some reason this is mandatory to repeat here
    name = style.cursorTheme.name;
    # size = style.cursorTheme.size + 8;
    hyprcursor = { enable = true; };
  };

  # SHELL
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    autocd = true;

    autosuggestion = { enable = true; };

    shellAliases = {
      lsl = "eza -1la --icons=always --group-directories-first";
      lsg = "eza -Gla --icons=always --group-directories-first";
      switch-nix = "sudo nixos-rebuild switch";
      pkgfnd-nix =
        "nix --extra-experimental-features 'nix-command flakes' search nixpkgs ";
      switch-home = "home-manager switch";
      fzyp = ''
        fzf --preview '${previewTextInFzf}' --info-command 'echo "Search and Copy path: $PWD"' | xargs -I {} wl-copy $PWD/{}'';
      fzon = ''
        fzf --preview '${previewTextInFzf}' --info-command 'echo "Search and Open in nvim: $PWD"' | xargs -I {} nvim $PWD/{}'';
      btmp = "btm -e";
    };

    history = { save = 10000; };

    syntaxHighlighting = { enable = true; };

    "oh-my-zsh" = {
      enable = true;
      plugins = [ "git" "asdf" "colored-man-pages" ];
      extraConfig = ''
        zstyle ':omz:update' mode auto      # update automatically without asking
        zstyle ':omz:update' frequency 13
      '';
    };
  };

  programs.starship = {
    enable = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
      add_newline = false;

      # character = {
      #   success_symbol = "[➜](bold green)";
      #   error_symbol = "[➜](bold red)";
      # };

      # package.disabled = true;
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

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    colors = {
      bg = "#${style.colors.background}";
      fg = "#${style.colors.text}";
      hl = "#${style.colors.highlight}";

      header = "#${style.colors.primary}";

      spinner = "#${style.colors.secondary}";
      info = "#${style.colors.info}";

      prompt = "#${style.colors.success}";
      marker = "#${style.colors.selection}";

      # Selected line
      pointer = "#${style.colors.primary}";
      "bg+" = "#${style.colors.activeSurface}";
      "fg+" = "#${style.colors.text}";
      "hl+" = "#${style.colors.highlight}";
    };
    fileWidgetOptions = [ "--preview '${previewTextInFzf}'" ];
    defaultOptions = [ "--multi" ];
  };

  programs.git = {
    enable = true;
    userEmail = "mika.drakolis@gmail.com";
    userName = "Mika Drakolis";
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

  programs.eza = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.navi = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = {
      style = {
        tag = {
          color = "white";
          width_percentage = 16;
          min_width = 20;
        };
        snippet = {
          color = "cyan";
          width_percentage = 32;
          min_width = 45;
        };
        comment = { color = "grey"; };
      };
      cheats = { paths = [ "~/Documents/cheatsheets" ]; };
      finder = { command = "fzf"; };
      shell = { command = "zsh"; };
    };
  };

  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    keymap = { };
    plugins = { };
    settings = {
      manager = {
        sort_by = "name";
        sort_dir_first = true;
        title_format = "yazi: {cwd}";
      };
    };
    theme = {
      manager = {

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

      window-theme = "ghostty";
      confirm-close-surface = false;

      window-decoration = true;
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
        foreground = style.colors.primary;
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
    keybindings = { };
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

      window_border_width = 0;
      window_padding_width = "5 5 0";

      tab_bar_edge = "bottom";
      tab_bar_margin_height = "2 2";
      tab_bar_style = "powerline";
      tab_powerline_style = "round";
      tab_activity_symbol = "*";
      tab_title_template =
        "{fmt.fg.tab}{index}: {title}{fmt.fg.red}{bell_symbol}{activity_symbol}";

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
      inactive_tab_foreground = "#${style.colors.textInverted}";
      inactive_tab_background = "#${style.colors.activeSurface}";
      inactive_tab_font_style = "bold";
      tab_bar_background = "#${style.colors.panel}";
      tab_bar_margin_color = "#${style.colors.panel}";

      foreground = "#${style.colors.text}";
      background = "#${style.colors.background}";
      selection_foreground = "#${style.colors.textInverted}";
      selection_background = "#${style.colors.secondary}";
      background_opacity = 0.97;
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

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd =
          "pidof hyprlock || hyprlock"; # avoid starting multiple hyprlock instances.
        before_sleep_cmd = "loginctl lock-session"; # lock before suspend.
        after_sleep_cmd =
          "hyprctl dispatch dpms on"; # to avoid having to press a key twice to turn on the display.
      };

      listener = [
        {
          timeout = 150; # 2.5min.
          on-timeout =
            "brightnessctl -s set 10"; # set monitor backlight to minimum, avoid 0 on OLED monitor.
          on-resume = "brightnessctl -r"; # monitor backlight restore.
        }

        # turn off keyboard backlight, comment out this section if you dont have a keyboard backlight.
        {
          timeout = 150; # 2.5min.
          on-timeout = ''
            brightnessctl -sd "tpacpi::kbd_backlight" set 0''; # turn off keyboard backlight.
          on-resume = ''
            brightnessctl -rd "tpacpi::kbd_backlight"''; # turn on keyboard backlight.
        }

        {
          timeout = 300; # 5min
          on-timeout =
            "loginctl lock-session"; # lock screen when timeout has passed
        }

        {
          timeout = 330; # 5.5min
          on-timeout =
            "hyprctl dispatch dpms off"; # screen off when timeout has passed
          on-resume =
            "hyprctl dispatch dpms on"; # screen on when activity is detected after timeout has fired.
        }

        {
          timeout = 1800; # 30min
          on-timeout = "systemctl suspend"; # suspend pc
        }
      ];
    };
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = false;
        hide_cursor = true;
      };
      auth = { fingerprint.enable = true; };
      background = {
        path = style.background;
        blur_passes = 1;
        color = "rgb(${style.colors.background})";
      };
      label = [
        {
          text = "Layout: $LAYOUT";
          color = "rgb(${style.colors.text})";
          font_size = 15;
          font_family = style.fontGui;
          position = "30, -20";
          halign = "left";
          valign = "top";

          shadow_passes = 1;
          shadow_size = 3;
          shadow_color = "rgb(${style.colors.shadow})";
          shadow_boost = 0.8;
        }
        {
          text = "$TIME";
          color = "rgb(${style.colors.text})";
          font_size = 90;
          font_family = style.fontGui;
          position = "-30, 0";
          halign = "right";
          valign = "top";

          shadow_passes = 1;
          shadow_size = 3;
          shadow_color = "rgb(${style.colors.shadow})";
          shadow_boost = 0.8;
        }
        {
          text = ''cmd[update:43200000] date +"%A, %d %B %Y"'';
          color = "rgb(${style.colors.text})";
          font_size = 25;
          font_family = style.fontGui;
          position = "-30, -130";
          halign = "right";
          valign = "top";

          shadow_passes = 1;
          shadow_size = 3;
          shadow_color = "rgb(${style.colors.shadow})";
          shadow_boost = 0.8;
        }
      ];
      image = {
        path = "$HOME/.face";
        size = 100;
        border_color = "rgb(${style.colors.primary})";
        position = "0, 75";
        halign = "center";
        valign = "center";

        shadow_passes = 1;
        shadow_size = 3;
        shadow_color = "rgb(${style.colors.shadow})";
        shadow_boost = 0.8;
      };
      input-field = {
        size = "350, 60";
        outline_thickness = 3;
        dots_size = 0.2;
        dots_spacing = 0.4;
        dots_center = true;
        outer_color = "rgb(${style.colors.primary})";
        inner_color = "rgb(${style.colors.activeSurface})";
        font_family = style.fontGui;
        font_color = "rgb(${style.colors.text})";
        fade_on_empty = false;
        placeholder_text = ''
          <span foreground="##${style.colors.text}"><i>󰌾 Logged in as </i><span foreground="##${style.colors.primary}">$USER</span></span>'';
        hide_input = false;
        check_color = "rgb(${style.colors.primary})";
        fail_color = "rgb(${style.colors.error})";
        fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
        capslock_color = "rgb(${style.colors.warning})";
        position = "0, -47";
        halign = "center";
        valign = "center";

        shadow_passes = 1;
        shadow_size = 3;
        shadow_color = "rgb(${style.colors.shadow})";
        shadow_boost = 0.8;
      };
    };
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = style.background;
      wallpaper = ", ${style.background}";
    };
  };

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        modules-left = [ "hyprland/workspaces" "hyprland/window" ];
        modules-center = [ "custom/notification" ];
        modules-right = [
          "hyprland/language"
          "pulseaudio"
          # "wireplumber"
          "backlight"
          "battery"
          "bluetooth"
          "network"
          "clock"
          "tray"
          "custom/lock"
          "custom/power"
        ];
        "hyprland/workspaces" = {
          active-only = false;
          all-outputs = true;
          format = " {icon} ";
          format-icons = {
            default = "";
            empty = "";
            special = "";
          };
          show-special = true;
          sort-by = "number";
        };
        "hyprland/window" = {
          separate-outputs = true;
          rewrite = {
            "(.*) — Mozilla Firefox" = "󰈹 $1";
            "Mozilla Firefox" = "󰈹";
            "(.*) - Visual Studio Code" = "󰨞 $1";
            "Visual Studio Code" = "󰨞";
            "(.*) - VSCodium" = " $1";
            "VSCodium" = "";
            "Telegram .*" = "";
          };
        };
        "custom/notification" = {
          tooltip = false;
          format = "{icon}";
          format-icons = {
            notification = "<span foreground='#${style.colors.error}'></span>";
            none = "";
            dnd-notification =
              "<span foreground='#${style.colors.error}'></span>";
            dnd-none = "";
            inhibited-notification =
              "<span foreground='#${style.colors.error}'></span>";
            inhibited-none = "";
            dnd-inhibited-notification =
              "<span foreground='#${style.colors.error}'></span>";
            dnd-inhibited-none = "";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };
        "hyprland/language" = {
          format-en = "󰘵 EN";
          format-ru = "󰘵 RU";
        };
        pulseaudio = {
          scroll-step = 5;
          format = "{icon} {volume}% {format_source}";
          format-source = "  {volume}%";
          format-source-muted = "   Mute";
          format-muted = "  Mute {format_source}";
          format-icons = { default = [ " " " " " " ]; };
          on-click = "pavucontrol";
          on-click-right = "helvum";
        };
        wireplumber = {
          scroll-step = 5;
          format = "{icon} {volume}%";
          # // "format-source": "  {volume}%",
          # // "format-source-muted": " Mute",
          format-muted = "  Mute";
          format-icons = [ "" "" " " ];
          on-click = "helvum";
          on-right-click = "pavucontrol";
        };
        backlight = {
          scroll-step = 5;
          device = "intel_backlight";
          format = "{icon} {percent}%";
          format-icons = [ "" "" "" "" "" "" "" "" "" ];
        };
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-icons = [ "" "" "" "" "" ];
        };
        bluetooth = {
          format = "󰂯";
          format-off = "󰂲";
          format-disabled = "󰂲";
          format-connected = "󰂯";
          tooltip-format = "{status} - {num_connections}";
          tooltip-format-disabled = "Disconnected";
          tooltip-format-off = "Disconnected";
          on-click = "blueman-manager";
        };
        network = {
          format = "󱘖";
          format-wifi = "{icon} {essid}";
          format-ethernet = "󰌘";
          format-disconnected = "󰤭";
          tooltip-format-wifi = "{ifname} - {signalStrength}% - {ipaddr}";
          tooltip-format-ethernet = "{ifname} - {ipaddr}";
          tooltip-format-disconnected = "Disconnected";
          tooltip-format = "Disconnected";
          format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
          on-click = "nm-connection-editor";
        };
        clock = {
          interval = 1;
          timezone = "Europe/Berlin";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
          format-alt = "󰃮 {:%d.%m.%Y}";
          format = "󰅐 {:%H:%M:%S}";
          on-right-click = "gsimplecal";
        };
        tray = {
          icon-size = 16;
          spacing = 10;
        };
      };
    };
    style = ''
      * {
        all: unset;
        font-family: "${style.fontGui}";
        font-weight: 500;
        font-size: ${toString (style.fontSize + 4)}px;
        min-height: 0;
      }

      #waybar {
        background: none;
        color: #${style.colors.text};
        margin: 5px;
      }

      /* Section - Any */
      #workspaces, #window, #tray, #custom-notification,
      #pulseaudio, #wireplumber, #backlight, #battery,
      #bluetooth, #network, #language, #custom-lock,
      #clock, #custom-power {
        background-color: #${style.colors.panel};
        padding: 0.6rem 1rem 0.5rem;
        margin-top: 5px;
      }

      /* Section - Single */
      #workspaces, #window, #tray, #custom-notification {
        border-radius: 2rem;
      }

      /* Section - Left */
      #language, #custom-loc {
        border-radius: 2rem 0 0 2rem;
        padding-right: 0.5rem;
      }

      /* Section - Middle */
      #pulseaudio, #wireplumber, #backlight, #battery,
      #bluetooth, #network {
        padding-left: 0.5rem;
        padding-right: 0.5rem;
      }

      /* Section - Right */
      #clock, #custom-power {
        border-radius: 0 2rem 2rem 0;
        padding-left: 0.5rem;
      }

      /* Section - Accent Color */
      #workspaces, #window, #tray {
        color: #${style.colors.primary};
      }

      /* Section - Workspaces */
      #workspaces {
        margin-left: 10px;
        padding: 0 0 0 0;
      }

      #workspaces button {
        border-radius: 2rem;
        padding: 0.6rem 0.45rem 0.5rem 0.1rem;
      }

      #workspaces button.active {
        background-color: #${style.colors.activeSurface};
      }

      #workspaces button.urgent {
        color: #${style.colors.error};
      }

      /* Section - Window */
      window#waybar.empty #window {
        margin-left: 5px;
        background-color: transparent;
      }

      /* Section - Notifications */
      #custom-notification {
        padding-left: 0.8rem;
      }

      /* Section - Shutdown */
      #custom-power {
        color: #${style.colors.error};
        margin-right: 10px;
      }

      /* Section - Keyboard */
      #language {
        color: #${style.colors.keyboard};
      }

      /* Section - Sound */
      #pulseaudio, #wireplumber {
        color: #${style.colors.sound};
      }

      /* Section - Brightness */
      #backlight {
        color: #${style.colors.brightness};
      }

      /* Section - Battery */
      #battery {
        color: #${style.colors.success};
      }

      /* Section - Battery Charging */
      #battery.charging {
        color: #${style.colors.info};
      }

      /* Section - Battery Low */
      #battery.warning:not(.charging) {
        color: #${style.colors.warning};
      }

      /* Section - Battery Critical */
      #battery.critical:not(.charging) {
        color: #${style.colors.error};
      }

      /* Section - Bluetooth */
      #bluetooth {
        color: #${style.colors.bluetooth};
      }

      /* Section - Network */
      #network {
        color: #${style.colors.network};
      }

      /* Section - Clock */
      #clock {
        color: #${style.colors.clock};
      }

      /* Section - Hovering */
      #workspaces button:hover, #pulseaudio:hover, #backlight:hover,
      #battery:hover, #bluetooth:hover, #network:hover, #clock:hover,
      #custom-power:hover, #custom-notification:hover, #language:hover,
      #custom-lock:hover, #wireplumber:hover {
        background-color: #${style.colors.activeSurface};
      }

      /* Popups */
      tooltip, #tray menu {
        background-color: #${style.colors.background};
        border-radius: 10px;
      }

      #tray menu *, tooltip label  {
        padding: 0.2rem;
        border-radius: 10px;
      }

      #tray menu *:hover {
        background: #${style.colors.activeSurface};
      }

      #tray {
        padding-top: 0.35rem;
      }
    '';
  };

}
