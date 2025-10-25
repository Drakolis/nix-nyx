{ lib, pkgs, ... }:
with lib;
{
  home.username = "drakolis";
  home.homeDirectory =
    if (pkgs.stdenv.hostPlatform.isDarwin) then "/Users/drakolis" else "/home/drakolis";

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
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
