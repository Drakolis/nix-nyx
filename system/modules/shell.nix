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
    gnupg
    jq # JSON parsing
    lynis # Security audit
    lynx # Terminal Browser
    ncdu
    ripgrep
    rsync
    smartmontools
    sops
    wget
  ];

  programs = {
    bat.enable = true;
    direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
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
