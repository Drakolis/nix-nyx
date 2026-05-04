{ pkgs, ... }:
{
  home.username = "neinhorn";
  home.homeDirectory =
    if (pkgs.stdenv.hostPlatform.isDarwin) then "/Users/neinhorn" else "/home/neinhorn";

  programs.home-manager.enable = true;

  programs.mulvad-vpn.enable = true;

  programs.git = {
    enable = true;
    signing.format = "openpgp";
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
