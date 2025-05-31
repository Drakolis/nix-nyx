{ pkgs, ... }:
{
  programs.elisa = {
    enable = true;
    package = null;
    appearance = {
      defaultView = "allAlbums";
      showNowPlayingBackground = true;
    };
    player.minimiseToSystemTray = true;
  };
}
