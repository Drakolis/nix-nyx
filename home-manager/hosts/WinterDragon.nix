{ pkgs, ... }:
{
  imports = [
    ../modules
    ../modules/desktop/kde
  ];

  drakolis = {
    flatpak = {
      enable = true;
      enableCommunication = true;
    };
    development = {
      enable = true;
      tools = {
        sqlClient = true;
        apiClient = true;
        scaleway = true;
      };
      languages = {
        nodeExtended = true;
        goExtended = true;
        extraLanguageServers = true;
      };
    };
    media = {
      enable = true;
    };
  };

  nixpkgs.config.permittedInsecurePackages = [
    "beekeeper-studio-5.1.5"
  ];

  # Nicely reload system units when changing configs
  # systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";

  home.keyboard = null;
}
