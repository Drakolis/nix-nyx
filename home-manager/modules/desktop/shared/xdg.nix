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
        "kitty"
      ];
    };
  };

  xdg.portal = {
    enable = true;
    config = {
      common = {
        default = [
          "gtk"
        ];
        "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
        "org.freedesktop.impl.portal.Access" = [
          "gtk"
        ];
        "org.freedesktop.impl.portal.Notification" = [ "gtk" ];
        "org.freedesktop.impl.portal.Screenshot" = [
          "wlr"
        ];
        "org.freedesktop.impl.portal.ScreenCast" = [
          "wlr"
        ];
      };
      kde = {
        default = [
          "kde"
        ];
        "org.freedesktop.impl.portal.Secret" = [ "kwallet" ];
        "org.freedesktop.impl.portal.Settings" = [
          "kde"
          "gtk"
        ];
      };
    };
  };
}
