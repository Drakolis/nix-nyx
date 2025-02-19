{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [ cryptomator keepassxc ];
}
