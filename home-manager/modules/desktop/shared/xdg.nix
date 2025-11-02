{ pkgs, ... }:
{
  home.packages = [
    pkgs.kdePackages.xdg-desktop-portal-kde
  ];
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
          "kde"
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
