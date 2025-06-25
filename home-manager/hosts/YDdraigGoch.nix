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
    };
    development = {
      enable = true;
      tools = {
        windsurf = true;
        sqlClient = true;
        mongoClient = true;
        apiClient = true;
        scaleway = true;
      };
      languages = {
        nodeExtended = true;
        pythonExtended = false;
        goExtended = true;
        lua = true;
        rust = false;
        java = true;
        terraform = false;
        extraLanguageServers = true;
      };
    };
    media = {
      enable = true;
      enablePhoto = true;
      enableVideoRecording = true;
      enable3DPrinting = true;
    };
    showoff.enable = true;
  };

  nixpkgs.config.permittedInsecurePackages = [
    "beekeeper-studio-5.2.12"
  ];

  # Nicely reload system units when changing configs
  # systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";

  home.keyboard = null;
}
