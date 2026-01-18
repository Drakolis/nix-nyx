{ pkgs, ... }:
{
  home.username = "neinhorn";
  home.homeDirectory =
    if (pkgs.stdenv.hostPlatform.isDarwin) then "/Users/neinhorn" else "/home/neinhorn";

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    settings = {
      init = {
        defaultBranch = "main";
      };
      pull = {
        rebase = true;
      };
    };
  };
}
