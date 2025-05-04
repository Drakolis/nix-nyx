let
  style = import ../../../constants/style.nix;
  commands = import ../../../constants/commands.nix;
in
{
  home.file = {
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
}
