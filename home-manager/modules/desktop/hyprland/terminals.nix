let
  style = import ../../../../constants/style.nix;
in
{
  programs.ghostty = {
    enable = false;
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
      size = style.fontMonospaceSize;
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
      paste_actions = "quote-urls-at-prompt,replace-newline,confirm,confirm-if-large";
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
      tab_title_template = "{fmt.fg.tab}{index}: {title} {fmt.fg.red}{bell_symbol}{activity_symbol}";

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
}
