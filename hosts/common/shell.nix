{ pkgs, ... }: {
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

  programs.bat.enable = true;
  programs.git.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
  programs.yazi.enable = true;
  programs.zsh.enable = true;
}
