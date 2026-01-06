{
  imports = [
    ../modules
    ../modules/desktop/niri
  ];

  drakolis = {
    deviceSettings = {
      formFactor = "desktop";
    };
    flatpak = {
      enable = true;
      enableCommunication = true;
      enableEntertainment = true;
      enableGameDevelopment = true;
      enableGaming = true;
    };
    development = {
      enable = true;
      tools = {
        aiEditors = true;
        sqlClient = true;
        mongoClient = true;
        apiClient = true;
        aws = true;
        googleCloud = true;
        scaleway = true;
        kubernetes = true;
      };
      languages = {
        nodeExtended = true;
        pythonExtended = true;
        goExtended = true;
        lua = true;
        rust = true;
        java = false;
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
    gaming.enable = true;
  };

  nixpkgs.config.permittedInsecurePackages = [
    "beekeeper-studio-5.3.4"
  ];

  # Nicely reload system units when changing configs
  # systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";

  home.keyboard = null;
}
