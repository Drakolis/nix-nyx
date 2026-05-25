{ pkgs, config, ... }:
let
  style = import ../../../../shared/constants/style.nix;

  gtkTheme = (
    pkgs.catppuccin-gtk.override {
      accents = [ "mauve" ];
      variant = "mocha";
    }
  );

  gtkThemeLight = (
    pkgs.catppuccin-gtk.override {
      accents = [ "mauve" ];
      variant = "latte";
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
    gtkThemeLight
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
    };

    gtk4 = {
      theme = config.gtk.theme;
      extraCss = ''
        .background {
          background: rgba(30, 30, 46, 0.92);
        }
        list.boxed-list, stack list {
          background: rgba(49, 50, 68, 0.9);
          border: none;
        }
        .sidebar-pane, .monitor-selection-container, gutterrenderer {
          background: rgba(24, 24, 37, 0.3);
        }
        .content-pane, .view, toolbarview {
          background: transparent;
        }
        .sound-view {
          background: transparent;
        }
      '';
    };

    gtk3 = {
      extraConfig = {
        gtk-menu-images = 1;
        gtk-button-images = 0;
      };
      extraCss = ''
        .thunar .standard-view.frame .view :selected {
          color: #11111b;
        }
        toolbar.horizontal {
          background: #181825;
          border-bottom: 1px solid #31323e;
        }
        .background {
          background: rgba(30, 30, 46, 0.92);
        }
        .view {
          background: transparent;
        }
        iconview, filechooser, treeview, notebook, treeview header button {
          background: transparent;
        }
        .sidebar, statusbar, .statusbar,
        toolbar.inline-toolbar, actionbar,
        viewport.frame list {
          background: rgba(24, 24, 37, 0.3);
        }
        entry {
          background: rgba(239, 241, 245, 0.08);
        }
        window.popup decoration, window.popup, window decoration {
          background: transparent;
        }
        menu {
          background: rgba(49, 50, 68, 0.92);
        }
      '';
      bookmarks = [
        "file://${config.xdg.userDirs.documents}"
        "file://${config.xdg.userDirs.pictures}"
        "file://${config.xdg.userDirs.videos}"
        "file://${config.xdg.userDirs.download}"
        "file://${config.home.homeDirectory}/Projects"
        "file://${config.home.homeDirectory}/Share"
      ];
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
