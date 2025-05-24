{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bat
    bottom
    curl
    duf # Disk usage
    entr # Reload when files change
    eza
    fd # File search
    ffmpeg
    fzf
    git
    gnupg
    jq # JSON parsing
    lynx # Terminal Browser
    ncdu
    neovim
    ripgrep
    rsync
    smartmontools
    sops
    wget
    yazi
  ];

  programs = {
    zsh.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
