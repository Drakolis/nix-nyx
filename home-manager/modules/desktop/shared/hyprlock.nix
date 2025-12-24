let
  style = import ../../../../share/constants/style.nix;
in
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = false;
        hide_cursor = true;
      };
      auth = {
        fingerprint.enable = true;
      };
      background = {
        path = style.background;
        blur_passes = 1;
        color = "rgb(${style.colors.background})";
      };
      label = [
        {
          text = "Layout: $LAYOUT";
          color = "rgb(${style.colors.text})";
          font_size = 15;
          font_family = style.fontGuiNerd;
          position = "30, -20";
          halign = "left";
          valign = "top";

          shadow_passes = 1;
          shadow_size = 3;
          shadow_color = "rgb(${style.colors.shadow})";
          shadow_boost = 0.8;
        }
        {
          text = ''cmd[update:60000] acpi'';
          color = "rgb(${style.colors.text})";
          font_size = 15;
          font_family = style.fontGuiNerd;
          position = "30, -50";
          halign = "left";
          valign = "top";

          shadow_passes = 1;
          shadow_size = 3;
          shadow_color = "rgb(${style.colors.shadow})";
          shadow_boost = 0.8;
        }
        {
          text = "$TIME";
          color = "rgb(${style.colors.text})";
          font_size = 90;
          font_family = style.fontGuiNerd;
          position = "-30, 0";
          halign = "right";
          valign = "top";

          shadow_passes = 1;
          shadow_size = 3;
          shadow_color = "rgb(${style.colors.shadow})";
          shadow_boost = 0.8;
        }
        {
          text = ''cmd[update:43200000] date +"%A, %d %B %Y"'';
          color = "rgb(${style.colors.text})";
          font_size = 25;
          font_family = style.fontGuiNerd;
          position = "-30, -130";
          halign = "right";
          valign = "top";

          shadow_passes = 1;
          shadow_size = 3;
          shadow_color = "rgb(${style.colors.shadow})";
          shadow_boost = 0.8;
        }
      ];
      image = {
        path = style.avatar;
        size = 175;
        border_color = "rgb(${style.colors.primary})";
        position = "0, 125";
        halign = "center";
        valign = "center";

        shadow_passes = 1;
        shadow_size = 3;
        shadow_color = "rgb(${style.colors.shadow})";
        shadow_boost = 0.8;
      };
      input-field = {
        size = "350, 60";
        outline_thickness = 3;
        dots_size = 0.2;
        dots_spacing = 0.4;
        dots_center = true;
        outer_color = "rgb(${style.colors.primary})";
        inner_color = "rgb(${style.colors.activeSurface})";
        font_family = style.fontGuiNerd;
        font_color = "rgb(${style.colors.text})";
        fade_on_empty = false;
        placeholder_text = ''<span foreground="##${style.colors.text}"><i>󰌾 Logged in as </i><span foreground="##${style.colors.primary}">$USER</span></span>'';
        hide_input = false;
        check_color = "rgb(${style.colors.primary})";
        fail_color = "rgb(${style.colors.error})";
        fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
        capslock_color = "rgb(${style.colors.warning})";
        position = "0, -47";
        halign = "center";
        valign = "center";

        shadow_passes = 1;
        shadow_size = 3;
        shadow_color = "rgb(${style.colors.shadow})";
        shadow_boost = 0.8;
      };
    };
  };
}
