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
  imports = [
    ./desktop/aerospace.nix
    ./browser.nix
    ./development
    ./espanso.nix
    ./flatpak.nix
    # ./glance.nix
    ./gaming.nix
    ./internet.nix
    ./media.nix
    ./neovim
    ./office.nix
    ./security
    ./shell.nix
    ./showoff.nix
    ./sync.nix
    ./terminals
    ./tui.nix
    ./unfree.nix
    ./yazi
  ];
}
