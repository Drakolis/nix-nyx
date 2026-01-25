{ pkgs, lib, ... }:
let
  style = import ../../share/constants/style.nix;
  commands = import ../../share/constants/commands.nix;
  paths = import ../../share/constants/paths.nix;
in
{
  xdg.configFile = {
    "tmux/plugins/tmux-which-key/config.yaml".text = lib.generators.toYAML { } {
      command_alias_start_index = 200;
      # rest of config here
    };
  };
  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    mouse = true;
    customPaneNavigationAndResize = true;
    shortcut = "a";
    extraConfig = ''
      unbind Space
      set-option -g status-position top
    '';
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.sensible;
      }
      {
        plugin = tmuxPlugins.catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor 'mocha'
          set -g @catppuccin_window_status_style "rounded"
          set -g status-right-length 100
          set -g status-left-length 100
          set -g status-left ""
        '';
      }
      {
        extraConfig = ''
          set -g status-right "#{E:@catppuccin_status_application}"
          set -ag status-right "#{E:@catppuccin_status_session}"
          set -ag status-right "#{E:@catppuccin_status_uptime}"
          set -agF status-right "#{E:@catppuccin_status_cpu}"
        '';

        plugin = tmuxPlugins.cpu;
      }
      {
        extraConfig = ''
          set -agF status-right "#{E:@catppuccin_status_battery}"
        '';
        plugin = tmuxPlugins.battery;
      }
    ];

  };
  programs.zellij = {
    enable = false;
    enableBashIntegration = true;
    enableZshIntegration = true;
    attachExistingSession = true;
    settings = {
      theme = "catppuccin-macchiato";
      show_startup_tips = false;
      ui = {
        pane_frames = {
          rounded_corners = true;
        };
      };
    };
    layouts = {
      default = {
        layout = {
          _children = [
            {
              default_tab_template = {
                _children = [
                  {
                    # pane = {
                    #   size = 1;
                    #   borderless = true;
                    #   plugin = {
                    #     location = "file://${zjstatusPath}";
                    #     format_left = "{mode} #[fg=#89B4FA,bold]{session}";
                    #     format_center = "{tabs}";
                    #     format_right = "{command_git_branch} {datetime}";
                    #     format_space = "";

                    #     border_enabled = "false";
                    #     border_char = "─";
                    #     border_format = "#[fg=#6C7086]{char}";
                    #     border_position = "top";

                    #     hide_frame_for_single_pane = "true";

                    #     mode_normal = "#[bg=blue] ";
                    #     mode_tmux = "#[bg=#ffc387] ";

                    #     tab_normal = "#[fg=#6C7086] {name} ";
                    #     tab_active = "#[fg=#9399B2,bold,italic] {name} ";

                    #     command_git_branch_command = "git rev-parse --abbrev-ref HEAD";
                    #     command_git_branch_format = "#[fg=blue] {stdout} ";
                    #     command_git_branch_interval = "10";
                    #     command_git_branch_rendermode = "static";

                    #     datetime = "#[fg=#6C7086,bold] {format} ";
                    #     datetime_format = "%H:%M:%S, %d %b %Y";
                    #     datetime_timezone = "Europe/Berlin";
                    #   };
                    # };
                  }
                  { "children" = { }; }
                  {
                    pane = {
                      size = 2;
                      borderless = true;
                      plugin = {
                        location = "zellij:status-bar";
                      };
                    };
                  }
                ];
              };
            }
          ];
        };
      };
    };
  };
}
