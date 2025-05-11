{
  home.username = "mika.zimina";
  home.homeDirectory = "/Users/mika.zimina";

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userEmail = "mika.zimina@bonial.com";
    userName = "Mika Zimina";
    aliases = {
      review = "push origin HEAD:refs/for/master";
    };
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };
}
