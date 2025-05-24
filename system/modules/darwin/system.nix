{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    betterdisplay
  ];
}
