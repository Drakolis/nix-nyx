{ lib, pkgs, ... }: {

  # dosbox

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "steam" "steam-unwrapped" ];

  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };

  programs.gamemode.enable = true;
}
