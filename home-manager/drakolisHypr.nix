{ pkgs, ... }:
{
  imports = [
    ./modules
    ./modules/hypr
    ./modules/tiling
    ./modules/terminals.nix
    ./modules/themesHypr.nix
  ];

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

  home.packages = with pkgs; [ caffeine-ng ];

  # Nicely reload system units when changing configs
  # systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";

  home.keyboard = null;
}
