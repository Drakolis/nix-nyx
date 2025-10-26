{ pkgs, ... }:
let
  theme-switch-fusion = pkgs.writeShellScriptBin "theme-switch-fusion" ''
    plasma-apply-colorscheme "CatppuccinMochaMauve"
  '';
  theme-switch-hacker = pkgs.writeShellScriptBin "theme-switch-hacker" ''
    plasma-apply-colorscheme "CatppuccinMochaBlue"
  '';
  theme-switch-creative = pkgs.writeShellScriptBin "theme-switch-creative" ''
    plasma-apply-colorscheme "CatppuccinMochaPink"
  '';
  theme-switch-engineer = pkgs.writeShellScriptBin "theme-switch-engineer" ''
    plasma-apply-colorscheme "CatppuccinMochaSapphire"
  '';
  theme-switch-adventurer = pkgs.writeShellScriptBin "theme-switch-adventurer" ''
    plasma-apply-colorscheme "CatppuccinMochaGreen"
  '';
  theme-switch-business = pkgs.writeShellScriptBin "theme-switch-business" ''
    plasma-apply-colorscheme "CatppuccinMochaRosewater"
  '';
in
{
  home.packages = with pkgs; [
    (catppuccin-kde.override {
      accents = [ "mauve" ];
      flavour = [ "mocha" ];
    })
    (catppuccin-kde.override {
      accents = [ "blue" ];
      flavour = [ "mocha" ];
    })
    (catppuccin-kde.override {
      accents = [ "pink" ];
      flavour = [ "mocha" ];
    })
    (catppuccin-kde.override {
      accents = [ "sapphire" ];
      flavour = [ "mocha" ];
    })
    (catppuccin-kde.override {
      accents = [ "green" ];
      flavour = [ "mocha" ];
    })
    (catppuccin-kde.override {
      accents = [ "rosewater" ];
      flavour = [ "mocha" ];
    })
    (catppuccin-kde.override {
      accents = [ "mauve" ];
      flavour = [ "latte" ];
    })
    (catppuccin-kde.override {
      accents = [ "blue" ];
      flavour = [ "latte" ];
    })
    (catppuccin-kde.override {
      accents = [ "pink" ];
      flavour = [ "latte" ];
    })
    (catppuccin-kde.override {
      accents = [ "sapphire" ];
      flavour = [ "latte" ];
    })
    (catppuccin-kde.override {
      accents = [ "green" ];
      flavour = [ "latte" ];
    })
    (catppuccin-kde.override {
      accents = [ "rosewater" ];
      flavour = [ "latte" ];
    })
    catppuccinifier-cli
    catppuccin-whiskers

    kdePackages.kconfig

    theme-switch-fusion
    theme-switch-hacker
    theme-switch-creative
    theme-switch-engineer
    theme-switch-adventurer
    theme-switch-business
  ];
}
