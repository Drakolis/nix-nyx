{ pkgs, ... }: {

  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;
    nativeMessagingHosts.packages =
      [ pkgs.kdePackages.plasma-browser-integration ];
    preferences = {
      "widget.use-xdg-desktop-portal.file-picker" = 1;
      "extensions.pocket.enabled" = false;
      "extensions.experiments.enabled" = true;
      "privacy.trackingprotection.enabled" = true;
    };

    policies = {
      ExtensionSettings = {
        # Proton Pass
        "78272b6fa58f4a1abaac99321d503a20@proton.me" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/proton-pass/latest.xpi";
          installation_mode = "force_installed";
        };
        # Proton VPN
        "vpn@proton.ch" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/proton-vpn-firefox-extension/latest.xpi";
          installation_mode = "force_installed";
        };
        # uBlock Origin
        "uBlock0@raymondhill.net" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        # React Dev Tools
        "@react-devtools" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/react-devtools/latest.xpi";
          installation_mode = "force_installed";
        };
        # Redux Dev Tools
        "extension@redux.devtools" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/reduxdevtools/latest.xpi";
          installation_mode = "force_installed";
        };
        # Vue.js Dev Tools
        "{5caff8cc-3d2e-4110-a88a-003cc85b3858}" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/vue-js-devtools/latest.xpi";
          installation_mode = "force_installed";
        };
        # Gesturefy
        "{506e023c-7f2b-40a3-8066-bc5deb40aebe}" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/gesturefy/latest.xpi";
          installation_mode = "force_installed";
        };
        # Plasma Integration (for KDE)
        "plasma-browser-integration@kde.org" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/plasma-integration/latest.xpi";
          installation_mode = "force_installed";
        };
        # Firefox Multi-Account Containers
        "@testpilot-containers" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/multi-account-containers/latest.xpi";
          installation_mode = "force_installed";
        };
        # Floccus (Bookmark Sync)
        "floccus@handmadeideas.org" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/floccus/latest.xpi";
          installation_mode = "force_installed";
        };
        # Dark Reader
        "addon@darkreader.org" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
          installation_mode = "force_installed";
        };
      };

      # Other recommended LibreWolf policies
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      FirefoxHome = {
        Search = true;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
      };
    };
  };

}
