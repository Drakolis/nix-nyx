{ lib, pkgs, ... }: {

  environment.systemPackages = with pkgs; [ dosbox mangohud piper ];

  services.ratbagd.enable = true; # Gaming mouse configuration

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "steam" "steam-unwrapped" ];

  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };

  # programs.gamemode.enable = true;
}
