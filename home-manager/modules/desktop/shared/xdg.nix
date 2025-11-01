{
  xdg.terminal-exec = {
    enable = true;
    settings = {
      kde = [
        "org.kde.Konsole"
      ];
      default = [
        "kitty.desktop"
      ];
    };
  };
  xdg.portal = {
    enable = true;
    config = {
      common = {
        default = [
          "lxqt"
          "gtk"
        ];
      };
      kde = {
        default = [
          "kde"
          "gtk"
        ];
      };
    };
  };
}
