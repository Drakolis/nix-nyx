{ lib, pkgs, ... }:
let
  grep = pkgs.gnugrep;
  desiredFlatpaks = [
    "com.slack.Slack"
    "it.fabiodistasio.AntaresSQL"
    "org.js.nuclear.Nuclear"
    "org.telegram.desktop"
    "us.zoom.Zoom"
    "com.valvesoftware.Steam"
    "com.heroicgameslauncher.hgl"
    "com.discordapp.Discord"
    "com.github.tchx84.Flatseal"
    "org.kde.kamoso"
  ];
in {
  home.activation = {
    myActivationAction = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      # 2. Ensure the Flathub repo is added
      ${pkgs.flatpak}/bin/flatpak remote-add --user --if-not-exists flathub \
        https://flathub.org/repo/flathub.flatpakrepo

      # 3. Get currently installed Flatpaks
      installedFlatpaks=$(${pkgs.flatpak}/bin/flatpak list --user --app --columns=application)

      # 4. Remove any Flatpaks that are NOT in the desired list
      for installed in $installedFlatpaks; do
        if ! echo ${
          toString desiredFlatpaks
        } | ${grep}/bin/grep -q $installed; then
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
}
