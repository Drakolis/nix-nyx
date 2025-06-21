let
  catppuccinMocha = import ./catppuccinMocha.nix;
in
{
  background = "~/nix-nyx/files/images/arch-wallpaper.png";
  avatar = "$HOME/.face";

  fontGui = "Ubuntu Sans";
  fontGuiNerd = "Ubuntu Nerd Font";
  fontMonospace = "JetBrainsMono Nerd Font";
  fontSize = 12;
  fontMonospaceSize = 12;
  fontSizeLarger = 14;
  fontSizeLargest = 16;

  opacity = {
    background = {
      decimal = 0.97;
      hex = "F7";
    };
    screen = {
      decimal = 0.9;
      hex = "F0";
    };
  };

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

  padding = {
    window = 10;
    notifications = 15;
    button = 5;
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
    activeOutline = catppuccinMocha.surface1;
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
    weather = catppuccinMocha.maroon;

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

    modeCommand = catppuccinMocha.peach;
    modeInsert = catppuccinMocha.sapphire;
    modeVisual = catppuccinMocha.rosewater;
    modeReplace = catppuccinMocha.maroon;
    modeInactive = catppuccinMocha.surface0;

    gitAdded = catppuccinMocha.green;
    gitRemoved = catppuccinMocha.red;
    gitMoved = catppuccinMocha.pink;
    gitModified = catppuccinMocha.yellow;
    gitCommit = catppuccinMocha.maroon;
    gitTime = catppuccinMocha.sapphire;
    gitAuthor = catppuccinMocha.teal;
    gitTag = catppuccinMocha.lavender;
    gitBranch = catppuccinMocha.sky;

    actionCopy = catppuccinMocha.green;
    actionMove = catppuccinMocha.maroon;

    permissionType = catppuccinMocha.blue;
    permissionRead = catppuccinMocha.peach;
    permissionWrite = catppuccinMocha.maroon;
    permissionExec = catppuccinMocha.green;
    permissionEmpty = catppuccinMocha.overlay1;

    filetypeAny = catppuccinMocha.text;
    filetypeImage = catppuccinMocha.teal;
    filetypeVideo = catppuccinMocha.yellow;
    filetypeArchive = catppuccinMocha.pink;
    filetypeDocument = catppuccinMocha.green;
    filetypeFolder = catppuccinMocha.blue;
  };
}
