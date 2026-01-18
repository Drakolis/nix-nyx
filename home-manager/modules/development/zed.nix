{
  config,
  pkgs,
  lib,
  ...
}:
let
  style = import ../../../share/constants/style.nix;
  cfg = config.drakolis.development;
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;

  bufferFontSize = style.fontMonospaceSizeLarger;
  uiFontSize = style.fontSizeLarger;
in
with lib;
{
  config = mkIf cfg.enable {
    programs.zed-editor = {
      enable = false;
      extensions = [
        "catppuccin"
        "symbols"
        "nix"
        "vue"
        "lua"
        "java"
        "terraform"
        "cspell"
        "git-firefly"
      ];
      # Zed settings
      #
      # For information on how to configure Zed, see the Zed
      # documentation: https://zed.dev/docs/configuring-zed
      #
      # To see all of Zed's default settings without changing your
      # custom settings, run `zed: open default settings` from the
      # command palette (cmd-shift-p / ctrl-shift-p)
      userSettings = {
        "language_models" = {
          "openai_compatible" = {
            "Scaleway" = {
              "api_url" = "https://api.scaleway.ai/v1";
              "available_models" = [
                {
                  "name" = "qwen3-coder-30b-a3b-instruct";
                  "display_name" = "Qwen3 Coder - Scaleway";
                  "max_tokens" = 128000;
                }
              ];
              "version" = "1";
            };
          };
        };

        "relative_line_numbers" = "enabled";
        "vim_mode" = true;
        "use_system_prompts" = false;
        "use_system_path_prompts" = false;

        "disable_ai" = false;
        "base_keymap" = "VSCode";
        "terminal" = {
          "dock" = "bottom";
        };
        "outline_panel" = {
          "dock" = "right";
        };
        "agent" = {
          "dock" = "left";
        };
        "icon_theme" = "Symbols Icon Theme";
        "tab_size" = 2;

        "indent_guides" = {
          "enabled" = true;
          "coloring" = "indent_aware";
        };
        "telemetry" = {
          "metrics" = false;
          "diagnostics" = false;
        };
        "ui_font_size" = uiFontSize;
        "ui_font_family" = "Ubuntu Sans";
        "ui_font_weight" = 500;
        "buffer_font_size" = bufferFontSize;
        "buffer_font_family" = "JetBrainsMono Nerd Font";
        "theme" = {
          "mode" = "dark";
          "light" = "Catppuccin Latte";
          "dark" = "Catppuccin Mocha";
        };
        "project_panel" = {
          "dock" = "right";
        };
        "git_panel" = {
          "dock" = "right";
        };
        "notification_panel" = {
          "dock" = "left";
        };
        "languages" = {
          "Nix" = {
            "language_servers" = [
              "nil"
              "!nixd"
            ];
          };
        };
      };
    };
  };
}
