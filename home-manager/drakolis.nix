{
  imports = [ ./modules ./modules/themes.nix ./modules/plasma-manager.nix ];

  home.username = "drakolis";
  home.homeDirectory = "/home/drakolis";

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userEmail = "mika.drakolis@pm.me";
    userName = "Mika Drakolis";
    extraConfig = { init = { defaultBranch = "main"; }; };
  };

  # Nicely reload system units when changing configs
  # systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";

  home.keyboard = null;
}
