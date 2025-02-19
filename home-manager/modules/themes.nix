{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    (catppuccin-kde.override {
      accents = [ "mauve" ];
      flavour = [ "mocha" ];
    })
    catppuccinifier-cli
    catppuccin-whiskers

    # Other DEs
    # qt6Packages.qt6ct
    # catppuccin-qt5ct
    # kdePackages.breeze
    # vanilla-dmz
    # catppuccin-papirus-folders

    # Kvantum support
    # qt6Packages.qtstyleplugin-kvantum
    # (catppuccin-kvantum.override {
    #   accent = "mauve";
    #   variant = "mocha";
    # })

    # GTK (Deprecated)
    # (catppuccin-gtk.override {
    #   accents = [ "mauve" ];
    #   variant = "mocha";
    # })

    nerd-fonts.ubuntu
    nerd-fonts.hack
    nerd-fonts.meslo-lg
  ];

  # home.pointerCursor = {
  #   package =
  #     pkgs.vanilla-dmz; # For some reason this is mandatory to repeat here
  #   name = "DMZ-Black";
  #   size = style.cursorTheme.size;
  #   hyprcursor.enable = true;
  #   gtk.enable = true;
  #   x11.enable = true;
  # };

  # gtk = {
  #   enable = true;
  #   cursorTheme = {
  #     name = "DMZ-Black";
  #     size = style.cursorTheme.size;
  #   };
  #   font = {
  #     name = style.fontGui;
  #     size = style.fontSize;
  #   };
  #   iconTheme = { name = style.iconTheme.name; };
  #   theme = { name = "drakolis-Catppuccin"; };
  #   gtk3.extraConfig = {
  #     gtk-menu-images = 1;
  #     gtk-button-images = 0;
  #   };
  # };

  # qt = {
  #   enable = true;
  #   platformTheme = { name = "qtct"; };
  #   # style = { name = "kvantum"; };
  # };
}
