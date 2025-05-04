{ pkgs, ... }:
{
  nixpkgs.config.librewolf.enablePlasmaBrowserIntegration = true;
  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;
    nativeMessagingHosts.packages = [ pkgs.kdePackages.plasma-browser-integration ];

    preferences = {
      "widget.use-xdg-desktop-portal.file-picker" = 1;
      "extensions.pocket.enabled" = false;
      "extensions.experiments.enabled" = true;
      "privacy.trackingprotection.enabled" = true;
      "privacy.resistFingerprinting.randomization.daily_reset.enabled" = true;
      "privacy.resistFingerprinting.randomization.daily_reset.private.enabled" = true;
      "privacy.resistFingerprinting.letterboxing" = true;
      "dom.security.https_only_mode" = true;
      "webgl.disabled" = true;
    };

    policies = {
      ExtensionSettings = {
        # Proton Pass
        "78272b6fa58f4a1abaac99321d503a20@proton.me" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/proton-pass/latest.xpi";
          installation_mode = "force_installed";
        };
        # Proton VPN
        "vpn@proton.ch" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/proton-vpn-firefox-extension/latest.xpi";
          installation_mode = "force_installed";
        };
        # uBlock Origin
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        # React Dev Tools
        "@react-devtools" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/react-devtools/latest.xpi";
          installation_mode = "force_installed";
        };
        # Redux Dev Tools
        "extension@redux.devtools" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/reduxdevtools/latest.xpi";
          installation_mode = "force_installed";
        };
        # Vue.js Dev Tools
        "{5caff8cc-3d2e-4110-a88a-003cc85b3858}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/vue-js-devtools/latest.xpi";
          installation_mode = "force_installed";
        };
        # Gesturefy
        "{506e023c-7f2b-40a3-8066-bc5deb40aebe}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/gesturefy/latest.xpi";
          installation_mode = "force_installed";
        };
        # Plasma Integration (for KDE)
        "plasma-browser-integration@kde.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/plasma-integration/latest.xpi";
          installation_mode = "force_installed";
        };
        # Firefox Multi-Account Containers
        "@testpilot-containers" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/multi-account-containers/latest.xpi";
          installation_mode = "force_installed";
        };
        # Floccus (Bookmark Sync)
        "floccus@handmadeideas.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/floccus/latest.xpi";
          installation_mode = "force_installed";
        };
        # Dark Reader
        "addon@darkreader.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
          installation_mode = "force_installed";
        };
        # StylUS
        "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/styl-us/latest.xpi";
          installation_mode = "force_installed";
        };
        # Privacy Badger
        "jid1-MnnxcxisBPnSXQ@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
          installation_mode = "force_installed";
        };
      };

      # Other recommended LibreWolf policies
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      PasswordManagerEnabled = false;
      FirefoxHome = {
        Search = true;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
      };
      TrackingProtection = {
        Enabled = true;
        Locked = true;
      };
    };
  };

}
