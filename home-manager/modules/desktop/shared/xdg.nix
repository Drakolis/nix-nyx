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
        "org.freedesktop.impl.portal.Secret" = [ "kwallet" ];
      };
      kde = {
        default = [
          "kde"
          "gtk"
        ];
        "org.freedesktop.impl.portal.Secret" = [ "kwallet" ];
      };
    };
  };
}
