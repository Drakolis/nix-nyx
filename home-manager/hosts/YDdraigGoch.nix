{ pkgs, ... }:
{
  imports = [
    ../modules
    ../modules/desktop/kde
  ];

  drakolis = {
    deviceSettings = {
      formFactor = "desktop";
    };
    flatpak = {
      enable = true;
      enableCommunication = true;
      enableEntertainment = true;
      enableGaming = true;
      enableBPGaming = true;
    };
    development = {
      enable = true;
      tools = {
        aiEditors = false;
        sqlClient = false;
        mongoClient = false;
        apiClient = false;
        scaleway = true;
      };
      languages = {
        nodeExtended = false;
        pythonExtended = false;
        goExtended = false;
        lua = false;
        rust = false;
        java = false;
        terraform = false;
        extraLanguageServers = false;
      };
    };
    gaming.enable = true;
    media = {
      enable = true;
      enablePhoto = true;
      enableVideoRecording = false;
      enable3DPrinting = false;
    };
    showoff.enable = true;
  };

  nixpkgs.config.permittedInsecurePackages = [
    "beekeeper-studio-5.5.3"
  ];

  # Nicely reload system units when changing configs
  # systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";

  home.keyboard = null;
}
