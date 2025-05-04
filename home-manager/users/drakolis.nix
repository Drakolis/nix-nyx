{
  home.username = "drakolis";
  home.homeDirectory = "/home/drakolis";

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userEmail = "mika.drakolis@pm.me";
    userName = "Mika Drakolis";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };
}
