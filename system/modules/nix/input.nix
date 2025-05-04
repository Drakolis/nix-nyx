{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vial
    solaar
  ];

  # Vial/Via support
  services.udev.packages = with pkgs; [
    vial
    via
  ];
}
