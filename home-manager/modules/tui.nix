{ pkgs, ... }:
let
  style = import ../../constants/style.nix;
in
{
  programs.bat = {
    enable = true;
    config = {
      theme = "Catppuccin Mocha";
    };
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
    extraPackages = with pkgs.bat-extras; [
      batdiff
      # batgrep
      batman
      batpipe
      batwatch
    ];
  };

  programs.bottom = {
    enable = true;
    settings = {
      flags = {
        battery = true;
      };
      styles = {
        widgets = {
          widget_title = {
            color = "#${style.colors.secondary}";
            bold = true;
          };
          border_color = "#${style.colors.tableLine}";
          selected_border_color = "#${style.colors.primary}";
          text = {
            color = "#${style.colors.text}";
          };
          selected_text = {
            color = "#${style.colors.textInverted}";
            bg_color = "#${style.colors.selection}";
          };
        };
        tables = {
          headers = {
            color = "#${style.colors.highlight}";
          };
        };
        battery = {
          high_battery_color = "#${style.colors.success}";
          medium_battery_color = "#${style.colors.warning}";
          low_battery_color = "#${style.colors.error}";
        };
        graphs = {
          graph_color = "#${style.colors.textDark}";
          legend_text = {
            color = "#${style.colors.textDark}";
          };
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
          ram_color = "#${style.colors.path}"; # This may be illogical, just uses shades of blue really
          swap_color = "#${style.colors.info}";
          gpu_colors = [ "magenta" ]; # ?????
          arc_color = "#${style.colors.highlight}";
        };
      };
    };
  };

  programs.gitui = {
    enable = true;
    keyConfig = ''
      (
        move_left: Some(( code: Char('h'), modifiers: "")),
        move_right: Some(( code: Char('l'), modifiers: "")),
        move_up: Some(( code: Char('k'), modifiers: "")),
        move_down: Some(( code: Char('j'), modifiers: "")),

        stash_open: Some(( code: Char('l'), modifiers: "")),
        open_help: Some(( code: F(1), modifiers: "")),

        status_reset_item: Some(( code: Char('U'), modifiers: "SHIFT")),
      )
    '';
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

  programs.zsh = {
    shellAliases = {
      fifs = "batgrep";
      man = "batman";
      gdf = "batdiff";
      btmp = "btm -e";
    };
  };
}
