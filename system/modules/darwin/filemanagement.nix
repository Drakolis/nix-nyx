{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    daisydisk
  ];
}
