{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bottom
    curl
    duf # Disk usage
    entr # Reload when files change
    eza
    fd # File search
    ffmpeg
    fzf
    gnupg
    httpie # HTTP requests
    jq # JSON parsing
    w3m # Terminal Browser
    ncdu # Disk usage
    ripgrep
    rsync
    smartmontools
    sops
    wget
  ];

  programs = {
    bat.enable = true;
    git.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
    yazi.enable = true;
    zsh.enable = true;
  };
}
