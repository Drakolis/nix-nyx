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
  theme-switch-fusion = pkgs.writeShellScriptBin "theme-switch-fusion" ''
    plasma-apply-colorscheme "CatppuccinMochaMauve"
  '';
  theme-switch-hacker = pkgs.writeShellScriptBin "theme-switch-hacker" ''
    plasma-apply-colorscheme "CatppuccinMochaBlue"
  '';
  theme-switch-creative = pkgs.writeShellScriptBin "theme-switch-creative" ''
    plasma-apply-colorscheme "CatppuccinMochaPink"
  '';
  theme-switch-engineer = pkgs.writeShellScriptBin "theme-switch-engineer" ''
    plasma-apply-colorscheme "CatppuccinMochaSapphire"
  '';
  theme-switch-adventurer = pkgs.writeShellScriptBin "theme-switch-adventurer" ''
    plasma-apply-colorscheme "CatppuccinMochaGreen"
  '';
  theme-switch-business = pkgs.writeShellScriptBin "theme-switch-business" ''
    plasma-apply-colorscheme "CatppuccinMochaRosewater"
  '';
in
{
  home.packages = with pkgs; [
    (catppuccin-kde.override {
      accents = [ "mauve" ];
      flavour = [ "mocha" ];
    })
    (catppuccin-kde.override {
      accents = [ "blue" ];
      flavour = [ "mocha" ];
    })
    (catppuccin-kde.override {
      accents = [ "pink" ];
      flavour = [ "mocha" ];
    })
    (catppuccin-kde.override {
      accents = [ "sapphire" ];
      flavour = [ "mocha" ];
    })
    (catppuccin-kde.override {
      accents = [ "green" ];
      flavour = [ "mocha" ];
    })
    (catppuccin-kde.override {
      accents = [ "rosewater" ];
      flavour = [ "mocha" ];
    })
    (catppuccin-kde.override {
      accents = [ "mauve" ];
      flavour = [ "latte" ];
    })
    (catppuccin-kde.override {
      accents = [ "blue" ];
      flavour = [ "latte" ];
    })
    (catppuccin-kde.override {
      accents = [ "pink" ];
      flavour = [ "latte" ];
    })
    (catppuccin-kde.override {
      accents = [ "sapphire" ];
      flavour = [ "latte" ];
    })
    (catppuccin-kde.override {
      accents = [ "green" ];
      flavour = [ "latte" ];
    })
    (catppuccin-kde.override {
      accents = [ "rosewater" ];
      flavour = [ "latte" ];
    })
    catppuccinifier-cli
    catppuccin-whiskers

    kdePackages.kconfig

    theme-switcher
    theme-switch-fusion
    theme-switch-hacker
    theme-switch-creative
    theme-switch-engineer
    theme-switch-adventurer
    theme-switch-business
  ];

  # Systemd user service
  # systemd.user.services.theme-switcher = {
  #   Unit = {
  #     Description = "Switch KDE theme based on time of day";
  #   };
  #   Service = {
  #     Type = "oneshot";
  #     ExecStart = "${theme-switcher}/bin/theme-switcher";
  #   };
  # };

  # systemd.user.timers.theme-switcher = {
  #   Unit = {
  #     Description = "Hourly check for KDE theme";
  #   };
  #   Timer = {
  #     OnBootSec = "5m"; # Run 5 minutes after login
  #     OnCalendar = "hourly";
  #     Persistent = true;
  #   };
  #   Install = {
  #     WantedBy = [ "timers.target" ];
  #   };
  # };
}
