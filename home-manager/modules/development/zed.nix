{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.drakolis.development;
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;

  bufferFontSize = if isDarwin then 13 else 14;
  uiFontSize = if isDarwin then 16 else 14;
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
        "agent" = {
          "dock" = "left";
          "default_model" = {
            "provider" = "zed.dev";
            "model" = "claude-sonnet-4-latest";
          };
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
