{ pkgs, ... }:
{
  imports = [
    ./modules/darwin
    ./modules/unfree.nix
  ];
}
