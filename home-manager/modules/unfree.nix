{ lib, pkgs, ... }:
{
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "windsurf"
      "obsidian"
      "mongodb-compass"
      "terraform"
    ];
}
