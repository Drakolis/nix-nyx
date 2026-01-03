{ pkgs, ... }:
let
  style = import ../../../../share/constants/style.nix;
in
{
  home.packages = with pkgs; [
    (catppuccin-kde.override {
      accents = [ "mauve" ];
      flavour = [ "mocha" ];
    })
    catppuccinifier-cli
    catppuccin-whiskers

    # Other DEs
    catppuccin-qt5ct
    kdePackages.breeze
    kdePackages.breeze-gtk
    kdePackages.breeze-icons
    vanilla-dmz
    (catppuccin-papirus-folders.override {
      accent = "mauve";
      flavor = "mocha";
    })

    qt6Packages.qt6ct
    # libsForQt5.qt5ct
    nwg-look

    # Kvantum support
    qt6Packages.qtstyleplugin-kvantum
    (catppuccin-kvantum.override {
      accent = "mauve";
      variant = "mocha";
    })

    # # GTK (Deprecated)
    (catppuccin-gtk.override {
      accents = [ "mauve" ];
      variant = "mocha";
    })
  ];

  home.pointerCursor = {
    package = pkgs.vanilla-dmz; # For some reason this is mandatory to repeat here
    name = "DMZ-Black";
    size = style.cursorTheme.size;
    #   hyprcursor.enable = true;
    gtk.enable = true;
    #   x11.enable = true;
  };

  gtk = {
    enable = true;
    colorScheme = "dark";
    cursorTheme = {
      name = "DMZ-Black";
      size = style.cursorTheme.size;
    };
    font = {
      name = style.fontGui;
      size = style.fontSize;
    };
    iconTheme = {
      name = "Papirus-Dark";
    };
    theme = {
      name = "catppuccin-mocha-mauve-standard";
      # name = "Breeze";
    };
    gtk3.extraConfig = {
      gtk-menu-images = 1;
      gtk-button-images = 0;
    };
  };

  qt = {
    enable = true;
    platformTheme = {
      name = "qtct";
    };
    # style = {
    #   name = "breeze";
    # };

  };

  home.file = {
    # This should be fixed in https://github.com/NixOS/nixpkgs/issues/355277
    ".config/Kvantum/catppuccin-mocha-mauve".source = "${
      (pkgs.catppuccin-kvantum.override {
        accent = "mauve";
        variant = "mocha";
      })
    }/share/Kvantum/catppuccin-mocha-mauve";
  };
}
