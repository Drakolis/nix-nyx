{
  terminal = "kitty";

  tui = {
    editor = "nvim";
    fileManager = "yazi";
  };

  gui = {
    browser = "firefox";
    editor = "codium";
    fileManager = "nemo";
  };

  previewText = "bat --paging=always --color=always";
  previewImage = "imv";

  notifyHyprpicker = ''
    notify-send -a "hyprpicker" -i "pick-colour-picker" "Color Picker" "Click to copy color"'';

  dialogue = { shutdown = "wlogout &"; };
}
