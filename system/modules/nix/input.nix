{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vial
    solaar
    wootility
  ];

  # Vial/Via support
  services.udev.packages = with pkgs; [
    vial
    via
  ];

  hardware.wooting.enable = true;
}
