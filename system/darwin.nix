{ pkgs, ... }:
{
  imports = [
    ./modules/darwin/homebrew.nix
    ./modules/darwin/nix.nix
    ./modules/darwin/shell.nix
    ./modules/darwin/terminal.nix
    ./modules/darwin/work.nix
  ];
}
