{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    nixd
    nixfmt-classic
    nix-tree
    nixos-generators
    nixos-option
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.command-not-found.enable = false;
  programs.nix-index = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
