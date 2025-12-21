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
          "gnome"
          "gtk"
        ];
        "org.freedesktop.impl.portal.Secret" = [ "kwallet" ];
        "org.freedesktop.impl.portal.Access" = [ "gtk" ];
        "org.freedesktop.impl.portal.Notification" = [ "gtk" ];
      };
      kde = {
        default = [
          "kde"
          "gnome"
          "gtk"
        ];
        "org.freedesktop.impl.portal.Secret" = [ "kwallet" ];
      };
    };
  };
}
