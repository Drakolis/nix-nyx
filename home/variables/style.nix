let catppuccinMocha = import ./catppuccinMocha.nix;
in {
  background = "~/.background";
  avatar = "~/.face";

  fontGui = "OpenDyslexic Nerd Font";
  # fontGui = "Ubuntu Nerd Font";
  fontMonospace = "MesloLGS Nerd Font";
  # fontMonospace = "UbuntuMono Nerd Font";
  fontReading = "OpenDyslexic Nerd Font";
  fontSize = 12;

  border = {
    outer = {
      width = 2;
      radius = 10;
    };
    inner = {
      width = 1;
      radius = 7;
    };
  };

  gaps = {
    inner = 5;
    outer = 10;
  };

  floatingDialogue = { };

  cursorTheme = {
    name = "catppuccin-mocha-dark-cursors";
    size = 24;
  };
  iconTheme = {
    name = "Papirus-Dark";
    size = 32;
  };

  colors = {
    primary = catppuccinMocha.mauve;
    secondary = catppuccinMocha.flamingo;
    highlight = catppuccinMocha.sky;

    error = catppuccinMocha.red;
    success = catppuccinMocha.green;
    warning = catppuccinMocha.yellow;
    info = catppuccinMocha.teal;

    locked = catppuccinMocha.peach;
    path = catppuccinMocha.blue;

    text = catppuccinMocha.text;
    textInverted = catppuccinMocha.crust;

    selection = catppuccinMocha.rosewater;

    textGray = catppuccinMocha.subtext1;
    textDark = catppuccinMocha.subtext0;

    activeSurface = catppuccinMocha.surface0;
    tableLine = catppuccinMocha.surface2;

    background = catppuccinMocha.base;
    panel = catppuccinMocha.mantle;
    shadow = catppuccinMocha.crust;

    # Waybar Modules
    keyboard = catppuccinMocha.sky;
    sound = catppuccinMocha.flamingo;
    brightness = catppuccinMocha.yellow;
    bluetooth = catppuccinMocha.blue;
    network = catppuccinMocha.lavender;
    clock = catppuccinMocha.sapphire;

    terminalBlack = catppuccinMocha.surface1;
    terminalRed = catppuccinMocha.red;
    terminalGreen = catppuccinMocha.green;
    terminalYellow = catppuccinMocha.peach;
    terminalBlue = catppuccinMocha.blue;
    terminalMagenta = catppuccinMocha.pink;
    terminalCyan = catppuccinMocha.teal;
    terminalGray = catppuccinMocha.subtext0;
    terminalBlack2 = catppuccinMocha.surface2;
    terminalRed2 = catppuccinMocha.maroon;
    terminalGreen2 = catppuccinMocha.green;
    terminalYellow2 = catppuccinMocha.yellow;
    terminalBlue2 = catppuccinMocha.sapphire;
    terminalMagenta2 = catppuccinMocha.flamingo;
    terminalCyan2 = catppuccinMocha.sky;
    terminalGray2 = catppuccinMocha.text;
  };
}
