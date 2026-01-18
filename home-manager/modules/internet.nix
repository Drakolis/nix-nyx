{ pkgs, lib, ... }:
let
  desiredInternetPackages = [
  ];
in
{
  home.packages = desiredInternetPackages;
}
