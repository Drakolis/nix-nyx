{ pkgs, ... }:
{
  imports = [
    ../modules
    ../modules/desktop/hyprland
    ../modules/desktop/niri
  ];

  drakolis = {
    deviceSettings = {
      formFactor = "laptop";
    };
    flatpak = {
      enable = true;
      enableCommunication = true;
    };
    development = {
      enable = true;
      tools = {
        aiEditors = true;
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
      enable = false;
    };
  };

  # Has no other image editing tools
  home.packages = [ pkgs.kdePackages.kolourpaint ];

  nixpkgs.config.permittedInsecurePackages = [
    "beekeeper-studio-5.3.4"
  ];

  # Nicely reload system units when changing configs
  # systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";

  home.keyboard = null;
}
