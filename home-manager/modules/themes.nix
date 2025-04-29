{ pkgs, ... }: {
  home.packages = with pkgs; [
    (catppuccin-kde.override {
      accents = [ "mauve" ];
      flavour = [ "mocha" ];
    })
    (catppuccin-kde.override {
      accents = [ "mauve" ];
      flavour = [ "latte" ];
    })
    catppuccinifier-cli
    catppuccin-whiskers
  ];

  services.darkman = {
    enable = true;

    lightModeScripts = {
      kde-theme = "plasma-apply-colorscheme CatppuccinLatteMauve";
    };

    darkModeScripts = {
      kde-theme = "plasma-apply-colorscheme CatppuccinMochaMauve";
    };

    settings = {
      lat = 52.520008;
      lng = 13.404954;
      usegeoclue = true;
    };
  };
}
