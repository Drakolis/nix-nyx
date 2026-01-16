{ pkgs, ... }:
let
  style = import ../../../../share/constants/style.nix;

  gtkTheme = (
    pkgs.catppuccin-gtk.override {
      accents = [ "mauve" ];
      variant = "mocha";
    }
  );

  gtkThemeColloid = (
    pkgs.colloid-gtk-theme.override {
      themeVariants = [ "purple" ];
      tweaks = [
        "catppuccin"
        "rimless"
      ];
    }
  );

in
{
  home.packages = with pkgs; [
    (catppuccin-kde.override {
      accents = [ "mauve" ];
      flavour = [ "mocha" ];
    })
    catppuccinifier-cli
    catppuccin-whiskers

    catppuccin-qt5ct
    kdePackages.breeze
    kdePackages.breeze-gtk
    vanilla-dmz
    (catppuccin-papirus-folders.override {
      accent = "mauve";
      flavor = "mocha";
    })

    qt6Packages.qt6ct
    nwg-look

    qt6Packages.qtstyleplugin-kvantum
    (catppuccin-kvantum.override {
      accent = "mauve";
      variant = "mocha";
    })

    gtkTheme
    gtkThemeColloid
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
      package = gtkTheme;
      # name = "Breeze";
    };
    gtk3.extraConfig = {
      gtk-menu-images = 1;
      gtk-button-images = 0;
    };
    gtk3.extraCss = ''
      .thunar .standard-view.frame .view :selected {
        color: #11111b;
      }
    '';
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
