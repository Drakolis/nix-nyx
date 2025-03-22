{ lib, pkgs, ... }: {

  environment.systemPackages = with pkgs; [ dosbox mangohud piper ];

  services.ratbagd.enable = true; # Gaming mouse configuration

  # programs.gamemode.enable = true;
}
