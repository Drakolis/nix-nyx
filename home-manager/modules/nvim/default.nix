{ pkgs, ... }:
let
  style = import ../../../shared/constants/style.nix;
in
{
  # A bit of an overkill. But treesitter doesn't work without gcc
  home.packages = with pkgs; [
    gcc
    tree-sitter
    vale # Linting for text files
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withRuby = false;
    withPython3 = false;

    plugins = [
      pkgs.vimPlugins.lazy-nvim
      pkgs.vimPlugins.avante-nvim
      pkgs.vimPlugins.plenary-nvim
      pkgs.vimPlugins.nui-nvim
      pkgs.vimPlugins.nvim-web-devicons
    ];

    # Ensure avante is on rtp early
    initLua = ''
      vim.opt.rtp:prepend("${pkgs.vimPlugins.avante-nvim}")
    '';
  };

  home.file = {
    ".config/nvim/" = {
      source = ../../../static/nvim;
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
