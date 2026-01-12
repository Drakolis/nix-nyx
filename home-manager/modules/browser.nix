{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  nativeMessagingHostsForPlatform =
    [ ]
    ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux [ pkgs.kdePackages.plasma-browser-integration ];

  trustedDomains = [
    "localhost"
    "nanowyrm"
    "joermungandr"
    "quetzalcoatl"
    "silverwing"
    "vaporserpent"
    "winterdragon"
    "yddraighgoch"
    "element.io"
    "startpage.com"
    "proton.me"
    "github.com"
    "gitlab.io"
    "perplexity.ai"
    "microsoft.com"
    "google.com"
    "youtube.com"
    "apple.com"
    "structured.app"
  ];

  timezoneDomains = [
    "calendly.com"
  ];

  firefoxExtensions = {
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
    # User-Agent Switcher and Manager
    "{a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7}" = {
      install_url = "https://addons.mozilla.org/firefox/downloads/file/4593736/user_agent_string_switcher-0.6.6.xpi";
      installation_mode = "force_installed";
    };
  };

  firefoxPolicies = {
    ExtensionSettings = firefoxExtensions;

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
    SearchEngines = {
      Default = "StartPage";
    };
  };

  firefoxProfileSearchEngines = {
    default = "StartPage";
    force = true;
    engines = {
      ecosia = {
        name = "Ecosia";
        urls = [ { template = "https://www.ecosia.org/search?q={searchTerms}"; } ];
        icon = "https://www.ecosia.org/favicon.ico";
        definedAliases = [ "@e" ];
      };

      startpage = {
        name = "StartPage";
        urls = [ { template = "https://www.startpage.com/sp/search?query={searchTerms}"; } ];
        icon = "https://www.startpage.com/favicon.ico";
        definedAliases = [ "@s" ];
      };

      nixpackages = {
        name = "Nix Packages";
        urls = [
          {
            template = "https://search.nixos.org/packages";
            params = [
              {
                name = "type";
                value = "packages";
              }
              {
                name = "query";
                value = "{searchTerms}";
              }
            ];
          }
        ];
        definedAliases = [ "@nixp" ];
        icon = "https://nixos.wiki/favicon.ico";
      };

      nixoptions = {
        name = "Nix Options";
        urls = [
          {
            template = "https://search.nixos.org/options";
            params = [
              {
                name = "type";
                value = "options";
              }
              {
                name = "query";
                value = "{searchTerms}";
              }
            ];
          }
        ];
        icon = "https://nixos.wiki/favicon.ico";
        definedAliases = [ "@nixo" ];
      };

      nixoswiki = {
        name = "NixOS Wiki";
        urls = [
          {
            template = "https://nixos.wiki/index.php";
            params = [
              {
                name = "search";
                value = "{searchTerms}";
              }
            ];
          }
        ];
        icon = "https://nixos.wiki/favicon.ico";
        definedAliases = [ "@nixw" ];
      };

      mynixos = {
        name = "MyNixOS";
        urls = [
          {
            template = "https://mynixos.com/search";
            params = [
              {
                name = "q";
                value = "{searchTerms}";
              }
            ];
          }
        ];
        icon = "https://nixos.wiki/favicon.ico";
        definedAliases = [ "@nixm" ];
      };

      bing.metaData.hidden = true;
      google.metaData.hidden = true;
    };
  };

  firefoxFingerprintingOverridesTrusted = map (x: {
    "firstPartyDomain" = x;
    "overrides" = "-JSDateTimeUTC,-CSSPrefersColorScheme";
  }) trustedDomains;

  firefoxFingerprintingOverridesTimezone = map (x: {
    "firstPartyDomain" = x;
    "overrides" = "-JSDateTimeUTC";
  }) timezoneDomains;

  firefoxFingerprintingOverrides =
    firefoxFingerprintingOverridesTrusted ++ firefoxFingerprintingOverridesTimezone;

  firefoxProfileAboutConfig = {
    "widget.use-xdg-desktop-portal.file-picker" = 1;
    "extensions.pocket.enabled" = false;
    "extensions.experiments.enabled" = true;
    "privacy.resistFingerprinting" = false;
    "privacy.resistFingerprinting.letterboxing" = false;
    "privacy.trackingprotection.enabled" = true;
    "privacy.fingerprintingProtection" = true;
    "privacy.fingerprintingProtection.overrides" = "+AllTargets";
    "privacy.fingerprintingProtection.granularOverrides" = firefoxFingerprintingOverrides;
    "dom.security.https_only_mode" = true;
    "browser.search.defaultenginename" = "StartPage";
    "browser.search.selectedEngine" = "startpage";
  };

  firefoxProfileAboutConfigHardcore = {
    "privacy.resistFingerprinting" = true;
    "privacy.resistFingerprinting.letterboxing" = true;
    "privacy.resistFingerprinting.randomization.daily_reset.enabled" = true;
    "privacy.resistFingerprinting.randomization.daily_reset.private.enabled" = true;
    "webgl.disabled" = true;
  };

  firefoxContainers = {
    "Personal" = {
      color = "green";
      icon = "fingerprint";
      id = 1;
    };
    "Work" = {
      color = "red";
      icon = "briefcase";
      id = 2;
    };
    "Shopping" = {
      color = "yellow";
      icon = "dollar";
      id = 3;
    };
  };
in
{
  nixpkgs.config.librewolf.enablePlasmaBrowserIntegration = pkgs.stdenv.hostPlatform.isLinux;

  programs.librewolf = {
    enable = true;
    nativeMessagingHosts = nativeMessagingHostsForPlatform;

    policies = firefoxPolicies;

    profiles.drakolis = {
      name = "drakolis";
      isDefault = true;
      search = firefoxProfileSearchEngines;

      containersForce = true;
      containers = firefoxContainers;

      settings = firefoxProfileAboutConfig;
    };
  };

  programs.zen-browser = {
    enable = true;
    nativeMessagingHosts = nativeMessagingHostsForPlatform;

    policies = firefoxPolicies;

    profiles.drakolis = {
      name = "drakolis";
      isDefault = true;
      search = firefoxProfileSearchEngines;

      containersForce = true;
      containers = firefoxContainers;

      settings = firefoxProfileAboutConfig;
    };
  };
}
