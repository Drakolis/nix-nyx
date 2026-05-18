{
  imports = [
    ../modules
  ];

  drakolis = {
    development = {
      enable = true;
      tools = {
        aiEditors = true;
        aiCli = true;
        sqlClient = false;
        apiClient = true;
        aws = true;
        kubernetes = true;
      };
      aiTools = {
        claudecode = true;
      };
      languages = {
        nodeExtended = true;
        pythonExtended = true;
        lua = true;
        java = true;
        rust = true;
        noIdea = true;
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
