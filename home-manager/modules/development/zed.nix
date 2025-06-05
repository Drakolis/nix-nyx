{
  config,
  lib,
  ...
}:
let
  cfg = config.drakolis.development;
in
with lib;
{
  config = mkIf cfg.enable {
    programs.zed-editor = {
      enable = true;
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
        "terminal" = {
          "dock" = "bottom";
        };
        "outline_panel" = {
          "dock" = "right";
        };
        "assistant" = {
          "dock" = "left";
          "version" = "2";
          # "default_model" = {
          #   "provider" = "ollama";
          #   "model" = "gemma3:latest";
          # };
        };
        "icon_theme" = "Symbols";
        "tab_size" = 2;

        "indent_guides" = {
          "enabled" = true;
          "coloring" = "indent_aware";
        };
        "telemetry" = {
          "metrics" = false;
          "diagnostics" = false;
        };
        "ui_font_size" = 16;
        "ui_font_family" = "Ubuntu Sans";
        "ui_font_weight" = 500;
        "buffer_font_size" = 14;
        "buffer_font_family" = "JetBrainsMono Nerd Font";
        "theme" = {
          "mode" = "system";
          "light" = "Catppuccin Latte";
          "dark" = "Catppuccin Mocha";
        };
        "project_panel" = {
          "dock" = "right";
        };
        "git_panel" = {
          "dock" = "right";
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
