{
  imports = [
    ../modules
    ../modules/desktop/kde
  ];

  programs.kodi = {
    enable = true;
  };

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
        aiEditors = false;
        sqlClient = false;
        mongoClient = false;
        apiClient = false;
        scaleway = true;
      };
      languages = {
        nodeExtended = true;
        pythonExtended = false;
        goExtended = true;
        lua = true;
        rust = true;
        java = false;
        terraform = false;
        extraLanguageServers = true;
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
    "beekeeper-studio-5.3.4"
  ];

  # Nicely reload system units when changing configs
  # systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";

  home.keyboard = null;
}
