let
  style = import ../../../../share/constants/style.nix;
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
}
