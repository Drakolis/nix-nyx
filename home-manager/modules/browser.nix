{ lib, pkgs, ... }: {
  programs.librewolf = {
    enable = true;
    nativeMessagingHosts = [ pkgs.kdePackages.plasma-browser-integration ];

    profiles.drakolis = {
      name = "drakolis";
      isDefault = true;
      search = {
        default = "ecosia";
        force = true;
        engines = {
          ecosia = {
            name = "Ecosia";
            urls =
              [{ template = "https://www.ecosia.org/search?q={searchTerms}"; }];
            icon = "https://www.ecosia.org/favicon.ico";
            definedAliases = [ "@e" ];
          };

          nixpackages = {
            name = "Nix Packages";
            urls = [{
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
            }];
            definedAliases = [ "@nixp" ];
            icon = "https://nixos.wiki/favicon.ico";
          };

          nixoptions = {
            name = "Nix Options";
            urls = [{
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
            }];
            icon = "https://nixos.wiki/favicon.ico";
            definedAliases = [ "@nixo" ];
          };

          nixoswiki = {
            name = "NixOS Wiki";
            urls = [{
              template = "https://nixos.wiki/index.php";
              params = [{
                name = "search";
                value = "{searchTerms}";
              }];
            }];
            icon = "https://nixos.wiki/favicon.ico";
            definedAliases = [ "@nixw" ];
          };

          mynixos = {
            name = "MyNixOS";
            urls = [{
              template = "https://mynixos.com/search";
              params = [{
                name = "q";
                value = "{searchTerms}";
              }];
            }];
            icon = "https://nixos.wiki/favicon.ico";
            definedAliases = [ "@nixm" ];
          };

          bing.metaData.hidden = true;
          google.metaData.hidden = true;
        };
      };

      settings = {
        "browser.search.defaultenginename" = "Ecosia";
        "browser.search.selectedEngine" = "ecosia";
      };
    };
  };
}
