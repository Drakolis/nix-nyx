{ pkgs, ... }:
{
  # Ghost writer

  # home.file = {
  #   ".local/share/ghostwriter/themes/HM_Catppuccin.json" = {
  #     source = ./files/catppuccin-mocha-mauve.json;

  #     onChange = ''
  #       rm -f ~/.local/share/ghostwriter/themes/Catppuccin.json
  #       cp ~/.local/share/ghostwriter/themes/HM_Catppuccin.json ~/.local/share/ghostwriter/themes/Catppuccin.json
  #       chmod u+w ~/.local/share/ghostwriter/themes/Catppuccin.json
  #     '';
  #   };
  # };

  # programs.ghostwriter = {
  #   enable = true;
  #   theme.customThemes = {
  #     catppuccin-mocha-mauve = ./files/catppuccin-mocha-mauve.json; # Somehow this doesn't work right
  #   };
  #   theme.name = "Catppuccin";
  # };
}
