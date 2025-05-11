{ pkgs, ... }:
{
  home.packages = with pkgs; [
    _1password-gui
    keepassxc
    proton-mail
    protonvpn
  ];
}
