{
  terminal = "kitty";

  tui = {
    editor = "nvim";
    fileManager = "yazi";
  };

  gui = {
    browser = "librewolf";
    editor = "codium";
    fileManager = "pcmanfm-qt";
    passwords = "proton-pass";
  };

  previewText = "bat --paging=always --color=always";
  previewTextInFzf = "bat --style=numbers --color=always --line-range 500 {}";
  previewImage = "imv";
  previewScreenshot = "imv -w Screenshot";

  fzfPreviewOptions = "--preview-window='right,50%,<50(down,50%)'";

  notifyHyprpicker = ''notify-send -a "hyprpicker" -i "pick-colour-picker" "Color Picker" "Click to copy color"'';

  dialogues = {
    runner = "wofi -I";
    runnerShift = "wofi --show run";
    runnerClipboard = "walker -m clipboard";
    shutdown = "wlogout -s";
  };

  autostart = [
    "element-desktop --hidden"
    "keepassxc"
    "proton-pass"
    "protonvpn-app"
    # "colima start &"
    "systemctl --user start hyprpolkitagent.service"
  ];
}
