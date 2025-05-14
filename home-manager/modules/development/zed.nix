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
        };
        "icon_theme" = "Symbols";
        "ui_font_size" = 14;
        "ui_font_family" = "Noto Sans";
        "ui_font_weight" = 500;
        "buffer_font_size" = 14;
        "buffer_font_family" = "Hack Nerd Font";
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
