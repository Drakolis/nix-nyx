{
  imports = [
    ../modules
  ];

  drakolis = {
    development = {
      enable = true;
      tools = {
        windsurf = true;
        sqlClient = false;
        apiClient = true;
        aws = true;
        kubernetes = true;
      };
      languages = {
        nodeExtended = true;
        pythonExtended = true;
        java = true;
        terraform = true;
        extraLanguageServers = true;
      };
    };
    media = {
      enable = false;
    };
  };

  # Nicely reload system units when changing configs
  # systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";

}
