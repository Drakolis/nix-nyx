{ pkgs, ... }:
{
  home.username = "drakolis";
  home.homeDirectory =
    if (pkgs.stdenv.hostPlatform.isDarwin) then "/Users/drakolis" else "/home/drakolis";

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    signing.format = "openpgpg";
    settings = {
      user = {
        email = "mika.drakolis@pm.me";
        name = "Mika Drakolis";
      };
      init = {
        defaultBranch = "main";
      };
      pull = {
        rebase = true;
      };
    };
  };
}
