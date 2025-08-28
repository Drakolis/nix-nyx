{
  imports = [
    ../modules
  ];

  drakolis = {
    development = {
      enable = true;
      tools = {
        aiEditors = false;
        sqlClient = false;
        mongoClient = true;
        apiClient = true;
        aws = true;
        googleCloud = true;
        scaleway = true;
        kubernetes = false;
      };
      languages = {
        nodeExtended = true;
        pythonExtended = true;
        java = false;
        terraform = true;
        extraLanguageServers = true;
      };
    };
    media = {
      enable = false;
    };
    showoff.enable = true;
  };

  # Nicely reload system units when changing configs
  # systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";

}
