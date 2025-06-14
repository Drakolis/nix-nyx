{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.drakolis.flatpak;
  grep = pkgs.gnugrep;

  flatpaks = [
    "org.kde.kamoso"
    "app.organicmaps.desktop"
  ];

  communicationFlatpaks = [
    "com.slack.Slack"
    "org.telegram.desktop"
    "us.zoom.Zoom"
  ];

  developmentFlatpaks = [
    "it.fabiodistasio.AntaresSQL"
  ];

  entertainmentFlatpaks = [
    "org.js.nuclear.Nuclear"
  ];

  gamingFlatpaks = [
    "com.valvesoftware.Steam"
    "com.discordapp.Discord"
    # "com.heroicgameslauncher.hgl"
  ];

  serviceFlatpaks = [
    "com.github.tchx84.Flatseal"
  ];

  desiredFlatpaks =
    flatpaks
    ++ lib.optionals cfg.enableCommunication communicationFlatpaks
    ++ lib.optionals cfg.enableDevelopment developmentFlatpaks
    ++ lib.optionals cfg.enableEntertainment entertainmentFlatpaks
    ++ lib.optionals cfg.enableGaming gamingFlatpaks
    ++ lib.optionals cfg.enableService serviceFlatpaks;
in
with lib;
{
  options = {
    drakolis.flatpak = {
      enable = mkOption {
        default = true;
        type = types.bool;
        description = ''
          Install flatpak software.
        '';
      };
      enableCommunication = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Install extra communication software.
        '';
      };
      enableDevelopment = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Install extra communication software.
        '';
      };
      enableEntertainment = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Install extra communication software.
        '';
      };
      enableGaming = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Install extra gaming software.
        '';
      };
      enableService = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Install extra service software.
        '';
      };
    };
  };

  config = mkIf (cfg.enable && !pkgs.stdenv.hostPlatform.isDarwin) {
    home.packages = with pkgs; [ flatpak ];

    home.activation = {
      myActivationAction = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        # 2. Ensure the Flathub repo is added
        ${pkgs.flatpak}/bin/flatpak remote-add --user --if-not-exists flathub \
          https://flathub.org/repo/flathub.flatpakrepo

        # 3. Get currently installed Flatpaks
        installedFlatpaks=$(${pkgs.flatpak}/bin/flatpak list --user --app --columns=application)

        # 4. Remove any Flatpaks that are NOT in the desired list
        for installed in $installedFlatpaks; do
          if ! echo ${toString desiredFlatpaks} | ${grep}/bin/grep -q $installed; then
            echo "Removing $installed because it's not in the desiredFlatpaks list."
            ${pkgs.flatpak}/bin/flatpak uninstall --user -y --noninteractive $installed
          fi
        done

        # 5. Install or re-install the Flatpaks you DO want
        for app in ${toString desiredFlatpaks}; do
          echo "Ensuring $app is installed."
          ${pkgs.flatpak}/bin/flatpak install --user -y flathub $app
        done

        # 6. Remove unused Flatpaks
        ${pkgs.flatpak}/bin/flatpak uninstall --user --unused -y

        # 7. Update all installed Flatpaks
        ${pkgs.flatpak}/bin/flatpak update --user -y
      '';
    };
  };
}
