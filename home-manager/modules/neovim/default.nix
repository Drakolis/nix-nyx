{ pkgs, ... }:
let
  style = import ../../../share/constants/style.nix;
in
{
  # A bit of an overkill. But treesitter doesn't work without gcc
  home.packages = with pkgs; [ gcc ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  home.file = {
    ".config/nvim/" = {
      source = ./files;
      recursive = true;
    };
    ".config/nvim/lua/colors.lua".text = ''
      local colors =
      {
        modeNormal = "#${style.colors.primary}",
        modeCommand = "#${style.colors.modeCommand}",
        modeInsert = "#${style.colors.modeInsert}",
        modeVisual = "#${style.colors.selection}",
        modeReplace = "#${style.colors.modeReplace}",
        modeInactive = "#${style.colors.modeInactive}",
        text = "#${style.colors.text}",
        textInverted = "#${style.colors.textInverted}",
        background = "#${style.colors.background}",
        panel = "#${style.colors.panel}",
        primary = "#${style.colors.primary}",
      }

      return colors
    '';
  };
}
