{ lib, pkgs, ... }:
{
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "mongodb-compass"
      "numi"
      "obsidian"
      "terraform"
      "windsurf"
    ];
}
