{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    nil
    nixd
    nixfmt-classic
    nix-tree
    nixos-generators
    nixos-option
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs = {
    command-not-found.enable = false;
    nix-index = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
  };
}
