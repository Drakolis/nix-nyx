{ pkgs, ... }:
{
  imports = [
    ./modules/darwin/nix.nix
    ./modules/darwin/shell.nix
  ];
}
