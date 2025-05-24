{ lib, pkgs, ... }:
with lib;
{
  home.username = "drakolis";
  home.homeDirectory =
    if (pkgs.stdenv.hostPlatform.isDarwin) then "/Users/drakolis" else "/home/drakolis";

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
