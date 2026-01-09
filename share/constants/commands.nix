{
  terminal = "rio";
  terminalExec = "rio -e";

  tui = {
    editor = "nvim";
    fileManager = "yazi";
  };

  gui = {
    browser = "zen";
    editor = "zeditor";
    fileManager = "thunar";
    passwords = "proton-pass";
  };

  previewText = "bat --paging=always --color=always";
  previewTextInFzf = "bat --style=numbers --color=always --line-range 500 {}";
  previewImage = "imv";
  previewScreenshot = "imv -w Screenshot";

  fzfPreviewOptions = "--preview-window='right,50%,<50(down,50%)'";

  notifyHyprpicker = ''notify-send -a "hyprpicker" -i "pick-colour-picker" "Color Picker" "Click to copy color"'';

  runner = "ignis open-window eggshell_launcher";
  runnerShift = "walker -m runner";
  runnerClipboard = "walker -m clipboard";
  shutdown = "ignis open-window eggshell_session_menu";

  autostart = [
    [ "tailscale-systray" ]
    [
      "niri-screen-time"
      "-daemon"
    ]
    [ "hyprpaper" ]
    [
      "syncthingtray"
      "--wait"
    ]
    [ "flameshot" ]
    [ "caffeine" ]
    [
      "ignis"
      "init"
    ]
  ];
}
