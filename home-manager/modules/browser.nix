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
in
{
  home.packages = [ inputs.zen-browser.packages.${pkgs.system}.default ];
  nixpkgs.config.librewolf.enablePlasmaBrowserIntegration = pkgs.stdenv.hostPlatform.isLinux;
  programs.librewolf = {
    enable = true;
    nativeMessagingHosts = nativeMessagingHostsForPlatform;

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
      SearchEngines = {
        Default = "StartPage";
      };
    };

    profiles.drakolis = {
      name = "drakolis";
      isDefault = true;
      search = {
        default = "StartPage";
        force = true;
        engines = {
          ecosia = {
            name = "Ecosia";
            urls = [ { template = "https://www.ecosia.org/search?q={searchTerms}"; } ];
            icon = "https://www.ecosia.org/favicon.ico";
            definedAliases = [ "@e" ];
          };

          # startpage = {
          #   name = "StartPage";
          #   urls = [ { template = "https://www.startpage.com/sp/search?query={searchTerms}"; } ];
          #   icon = "https://www.startpage.com/favicon.ico";
          #   definedAliases = [ "@s" ];
          # };

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

      settings = {
        "widget.use-xdg-desktop-portal.file-picker" = 1;
        "extensions.pocket.enabled" = false;
        "extensions.experiments.enabled" = true;
        "privacy.resistFingerprinting" = false;
        "privacy.resistFingerprinting.letterboxing" = false;
        "privacy.resistFingerprinting.randomization.daily_reset.enabled" = true;
        "privacy.resistFingerprinting.randomization.daily_reset.private.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.fingerprintingProtection" = true;
        "privacy.fingerprintingProtection.overrides" = "+AllTargets";
        "privacy.fingerprintingProtection.granularOverrides" = [
          # Local
          {
            "firstPartyDomain" = "localhost";
            "overrides" = "-JSDateTimeUTC,-CSSPrefersColorScheme";
          }
          {
            "firstPartyDomain" = "nanowyrm";
            "overrides" = "-JSDateTimeUTC,-CSSPrefersColorScheme";
          }
          # Safe
          {
            "firstPartyDomain" = "element.io";
            "overrides" = "-JSDateTimeUTC,-CSSPrefersColorScheme";
          }
          {
            "firstPartyDomain" = "startpage.com";
            "overrides" = "-CSSPrefersColorScheme";
          }
          {
            "firstPartyDomain" = "proton.me";
            "overrides" = "-JSDateTimeUTC,-CSSPrefersColorScheme";
          }
          # Gits
          {
            "firstPartyDomain" = "github.io";
            "overrides" = "-JSDateTimeUTC,-CSSPrefersColorScheme";
          }
          {
            "firstPartyDomain" = "gitlab.io";
            "overrides" = "-JSDateTimeUTC,-CSSPrefersColorScheme";
          }
          # Already knows a lot about me
          {
            "firstPartyDomain" = "perplexity.ai";
            "overrides" = "-JSDateTimeUTC,-CSSPrefersColorScheme";
          }
          {
            "firstPartyDomain" = "microsoft.com";
            "overrides" = "-JSDateTimeUTC,-CSSPrefersColorScheme";
          }
          {
            "firstPartyDomain" = "google.com";
            "overrides" = "-JSDateTimeUTC,-CSSPrefersColorScheme";
          }
          # Just for the sake of time
          {
            "firstPartyDomain" = "calendly.com";
            "overrides" = "-JSDateTimeUTC";
          }
        ];
        "dom.security.https_only_mode" = true;
        "webgl.disabled" = true;
        "browser.search.defaultenginename" = "StartPage";
        "browser.search.selectedEngine" = "startpage";
      };
    };
  };
}
