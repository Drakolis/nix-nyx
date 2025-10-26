{ pkgs, ... }:
let
  style = import ../../../../constants/style.nix;
  commands = import ../../../../constants/commands.nix;
in
{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "${style.fontGui}:size=${toString (style.fontSizeLarger)}";
        use-bold = true;
      };
      border = {
        width = style.border.outer.width;
        radius = style.border.outer.radius;
        selection-radius = style.border.inner.radius;
      };
      colors = {
        background = "${style.colors.panel}${style.opacity.background.hex}";
        text = "${style.colors.text}ff";
        match = "${style.colors.text}ff";

        prompt = "${style.colors.success}ff";
        input = "${style.colors.text}ff";
        placeholder = "${style.colors.textGray}ff";

        selection = "${style.colors.primary}ff";
        selection-text = "${style.colors.textInverted}ff";
        selection-match = "${style.colors.textInverted}ff";

        counter = "${style.colors.secondary}ff";
        border = "${style.colors.primary}ff";
      };
    };
  };

  programs.anyrun = {
    enable = true;
    config = {
      x = {
        fraction = 0.5;
      };
      y = {
        fraction = 0.3;
      };
      width = {
        fraction = 0.4;
      };
      hideIcons = false;
      ignoreExclusiveZones = false;
      layer = "overlay";
      hidePluginInfo = false;
      closeOnClick = false;
      showResultsImmediately = false;
      maxEntries = null;

      plugins = [
        "${pkgs.anyrun}/lib/libapplications.so"
        "${pkgs.anyrun}/lib/libsymbols.so"
        "${pkgs.anyrun}/lib/libshell.so"
        "${pkgs.anyrun}/lib/libtranslate.so"
        "${pkgs.anyrun}/lib/librink.so"
        "${pkgs.anyrun}/lib/libkidex.so"
        "${pkgs.anyrun}/lib/libstdin.so"
        "${pkgs.anyrun}/lib/libdictionary.so"
        "${pkgs.anyrun}/lib/libwebsearch.so"
        "${pkgs.anyrun}/lib/libnix_run.so"
        "${pkgs.anyrun}/lib/libniri_focus.so"
      ];
    };

    # Inline comments are supported for language injection into
    # multi-line strings with Treesitter! (Depends on your editor)
    extraCss = /* css */ ''
      @define-color accent #${style.colors.primary};
      @define-color bg-color #${style.colors.panel};
      @define-color fg-color #${style.colors.text};
      @define-color desc-color #${style.colors.textGray};
      @define-color shadow-color #${style.colors.shadow};

      window {
        font-size: ${toString style.fontSizeLarger}px;
        font-family: ${style.fontGuiNerd};
        background: transparent;
      }

      box.main {
        padding: ${toString style.padding.window}px;
        margin: 10px;
        border-radius: ${toString style.border.outer.radius}px;
        border: ${toString style.border.outer.width}px solid @accent;
        background-color: @bg-color;
        box-shadow: 0 0 3px 2px #${style.colors.shadow};
      }

      text {
        min-height: 30px;
        padding: ${toString style.padding.button}px;
        border-radius: 5px;
        color: @fg-color;
      }

      .matches {
        background: transparent;
      }

      box.plugin:first-child {
        margin-top: 5px;
      }

      box.plugin.info {
        min-width: 200px;
      }

      list.plugin {
        background: transparent;
      }

      label.match {
        color: @fg-color;
      }

      label.match.description {
        font-size: ${toString style.fontSize}px;
        color: @desc-color;
      }

      label.plugin.info {
        font-size: ${toString style.fontSizeLarger}px;
      }

      .match {
        border-left: 4px solid transparent;
        background: transparent;
      }

      .match:selected {
        border-left: 4px solid @accent;
        background: transparent;
      }
    '';

    # extraConfigFiles."some-plugin.ron".text = ''
    #   Config(
    #     // for any other plugin
    #     // this file will be put in ~/.config/anyrun/some-plugin.ron
    #     // refer to docs of xdg.configFile for available options
    #   )
    # '';
  };
}
