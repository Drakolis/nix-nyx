{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nil
    nixfmt-rfc-style
    nix-tree
    nixos-generators
    nixos-option
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  programs = {
  };
}
