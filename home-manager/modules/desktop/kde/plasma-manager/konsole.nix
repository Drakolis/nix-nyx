{
  programs.konsole = {
    enable = true;
    customColorSchemes = {
      catppuccin-mocha = ./files/catppuccin-mocha.colorscheme;
    };
    defaultProfile = "Drakolis";
    profiles = {
      "Drakolis" = {
        colorScheme = "catppuccin-mocha";
        font.size = 11;
      };
    };
    ui.colorScheme = "Catppuccin Mocha Mauve"; # To keep it always dark

    extraConfig = {
      MainWindow.MenuBar = true;
      TabBar.ExpandTabWidth = true;
    };
  };
}
