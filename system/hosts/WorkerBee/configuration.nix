{ pkgs, ... }:
{
  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    home-manager
  ];

  drakolis.desktop = {
    profiles = [
      "advanced"
      "downloads"
      "media"
      "office"
      "security"
      "remoteDesktop"
      "work"
    ];
  };

  # TEMP ALL
  services.yabai.enable = false;

  services.yabai.config = {
    external_bar = "off:40:0";
    menubar_opacity = 1.0;
    mouse_follows_focus = "off";
    focus_follows_mouse = "off";
    display_arrangement_order = "default";
    window_origin_display = "default";
    window_placement = "second_child";
    window_insertion_point = "focused";
    window_zoom_persist = "on";
    window_shadow = "on";
    window_animation_duration = 0.0;
    window_animation_easing = "ease_out_circ";
    window_opacity_duration = 0.0;
    active_window_opacity = 1.0;
    normal_window_opacity = 0.90;
    window_opacity = "off";
    insert_feedback_color = "0xffd75f5f";
    split_ratio = 0.50;
    split_type = "auto";
    auto_balance = "off";
    top_padding = 12;
    bottom_padding = 12;
    left_padding = 12;
    right_padding = 12;
    window_gap = 6;
    layout = "bsp";
    mouse_modifier = "fn";
    mouse_action1 = "move";
    mouse_action2 = "resize";
    mouse_drop_action = "swap";
  };

  # Enable alternative shell support in nix-darwin.
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;
}
