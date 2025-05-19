{ pkgs, ... }:
{
  imports = [
    ./modules/darwin
    ./modules/fonts.nix
    ./modules/unfree.nix
  ];
}
