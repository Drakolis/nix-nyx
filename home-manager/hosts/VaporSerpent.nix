{
  imports = [
    ../modules
    ../modules/desktop/kde
  ];

  drakolis = {
    deviceSettings = {
      formFactor = "laptop";
    };
    flatpak = {
      enable = true;
      enableCommunication = true;
      enableEntertainment = true;
      enableGaming = true;
    };
    development = {
      enable = false;
    };
    media = {
      enable = true;
      enableVideoRecording = true;
    };
  };

  nixpkgs.config.permittedInsecurePackages = [
    "beekeeper-studio-5.5.3"
  ];

  # Nicely reload system units when changing configs
  # systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";

  home.keyboard = null;
}
