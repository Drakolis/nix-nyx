{ pkgs, ... }:
let
  # Script that switches the KDE theme based on time
  theme-switcher = pkgs.writeShellScriptBin "theme-switcher" ''
    #!/bin/sh

    # Configuration (adjust these)
    DAY_START=7
    NIGHT_START=18
    DAY_THEME="CatppuccinLatteMauve"
    NIGHT_THEME="CatppuccinMochaMauve"

    # Get current hour (24h format)
    current_hour=$(date +%H)

    # Determine theme
    if [ "$current_hour" -ge "$DAY_START" ] && [ "$current_hour" -lt "$NIGHT_START" ]; then
      new_theme="$DAY_THEME"
    else
      new_theme="$NIGHT_THEME"
    fi

    # Get current theme
    current_theme=$(kreadconfig6 --group General --key ColorScheme)

    if [ "$current_theme" != "$new_theme" ]; then
      echo "Switching KDE theme to $new_theme"

      plasma-apply-colorscheme "$new_theme"
    fi
  '';
in
{
  home.packages = with pkgs; [
    (catppuccin-kde.override {
      accents = [ "mauve" ];
      flavour = [ "mocha" ];
    })
    (catppuccin-kde.override {
      accents = [ "mauve" ];
      flavour = [ "latte" ];
    })
    catppuccinifier-cli
    catppuccin-whiskers

    kdePackages.kconfig

    theme-switcher
  ];

  # Systemd user service
  systemd.user.services.theme-switcher = {
    Unit = {
      Description = "Switch KDE theme based on time of day";
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${theme-switcher}/bin/theme-switcher";
    };
  };

  systemd.user.timers.theme-switcher = {
    Unit = {
      Description = "Hourly check for KDE theme";
    };
    Timer = {
      OnBootSec = "5m"; # Run 5 minutes after login
      OnCalendar = "hourly";
      Persistent = true;
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };
}
