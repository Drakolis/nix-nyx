{ pkgs, ... }:
{
  imports = [
    ../modules
    ../modules/desktop/kde
  ];

  drakolis.flatpak = {
    enable = true;
    enableCommunication = true;
    enableGaming = true;
    enableService = false;
  };

  # Nicely reload system units when changing configs
  # systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";

  home.keyboard = null;
}
