{ pkgs, ... }:
{
  home.username = "mika.zimina";
  home.homeDirectory =
    if (pkgs.stdenv.hostPlatform.isDarwin) then "/Users/mika.zimina" else "/home/mika.zimina";

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "mika.zimina@bonial.com";
        name = "Mika Zimina";
      };
      init = {
        defaultBranch = "main";
      };
      pull = {
        rebase = true;
      };
    };
    aliases = {
      review = "push origin HEAD:refs/for/master";
    };
  };
}
