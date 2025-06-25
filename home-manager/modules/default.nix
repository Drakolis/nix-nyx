{ lib, ... }:
let
  formFactors = lib.types.enum [
    "laptop"
    "desktop"
    "tablet"
  ];
in
with lib;
{
  options = {
    drakolis.deviceSettings = {
      formFactor = mkOption {
        default = "laptop";
        type = formFactors;
        description = ''
          Form factor of the device. Affects power management settings, animation settings, and more.
          This option also changes the appearance and some elements of the desktop environment.
        '';
      };
      disableSleep = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Disable automatic sleep mode.
        '';
      };
    };
  };
  config = {
    imports = [
      ./browser.nix
      ./development
      ./flatpak.nix
      ./internet.nix
      ./media.nix
      ./neovim
      ./office.nix
      ./security
      ./shell.nix
      ./showoff.nix
      ./sync.nix
      ./tui.nix
      ./unfree.nix
      ./yazi
      ./walker.nix
    ];
  };
}
