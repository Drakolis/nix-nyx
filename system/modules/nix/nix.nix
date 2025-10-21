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
    command-not-found.enable = true;
    direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
