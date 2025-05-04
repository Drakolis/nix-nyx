{ pkgs, ... }:
{
  imports = [
    ../modules
    ../modules/themes.nix
    ../modules/plasma-manager.nix
  ];

  drakolis.flatpak = {
    enable = true;
    enableCommunication = true;
    enableGaming = false;
    enableService = false;
  };

  # Nicely reload system units when changing configs
  # systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";

  home.keyboard = null;
}
