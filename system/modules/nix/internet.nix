{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ termshark ];
}
