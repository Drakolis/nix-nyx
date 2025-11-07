{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = mkIf (!pkgs.stdenv.hostPlatform.isDarwin) {
    services.glance = {
      enable = true;
      settings = {
        theme = {
          background-color = "240 21 15";
          contrast-multiplier = 1.2;
          primary-color = "217 92 83";
          positive-color = "115 54 76";
          negative-color = "347 70 65";
        };
        pages = [
          {
            columns = [
              {
                size = "small";
                widgets = [
                  {
                    type = "calendar";
                  }
                  {
                    location = "Berlin, Germany";
                    type = "weather";
                    units = "metric";
                    hour-format = "24h";
                  }
                  {
                    type = "clock";
                    hour-format = "24h";
                    timezones = [
                      {
                        timezone = "America/Sao_Paulo";
                        label = "Belo Horizonte";
                      }
                      {
                        timezone = "Europe/Lisbon";
                        label = "Lisbon";
                      }
                      {
                        timezone = "Europe/Berlin";
                        label = "Berlin";
                      }
                      {
                        timezone = "Europe/Moscow";
                        label = "Saint Petersburg";
                      }
                      {
                        timezone = "Asia/Yekaterinburg";
                        label = "Yekaterinburg";
                      }
                    ];
                  }
                ];
              }
              {
                size = "full";
                widgets = [
                  {
                    type = "videos";
                    style = "grid-cards";
                    limit = 30;
                    channels = [
                      "UCHnj59g7jezwTy5GeL8EA_g" # MindYourDecisions
                      "UCT_AKsYn-zjTC12CjCyp3dw" # ArkadiyGershman
                      "UC0intLFzLaudFG-xAvUEO-A" # NotJustBikes
                      "UCGc8ZVCsrR3dAuhvUbkbToQ" # CityBeautiful
                      "UCzX1PrvY44I0KMu4auMK7-w" # MoskvichnaMoskvichah
                    ];
                  }
                  {
                    type = "group";
                    widgets = [
                      {
                        type = "rss";
                        title = "Meduza";
                        style = "vertical-list";
                        single-line-titles = true;
                        limit = 25;
                        cache = "1h";
                        collapse-after = 10;
                        feeds = [ { url = "https://meduza.io/rss2/all"; } ];
                      }
                      {
                        type = "rss";
                        title = "DW: Germany";
                        style = "vertical-list";
                        single-line-titles = true;
                        limit = 25;
                        cache = "1h";
                        collapse-after = 10;
                        feeds = [ { url = "https://rss.dw.com/rdf/rss-en-ger"; } ];
                      }
                      {
                        type = "rss";
                        title = "DW: World";
                        style = "vertical-list";
                        single-line-titles = true;
                        limit = 25;
                        cache = "1h";
                        collapse-after = 10;
                        feeds = [ { url = "https://rss.dw.com/rdf/rss-en-world"; } ];
                      }
                      {
                        type = "rss";
                        title = "DW: Europe";
                        style = "vertical-list";
                        single-line-titles = true;
                        limit = 25;
                        cache = "1h";
                        collapse-after = 10;
                        feeds = [ { url = "https://rss.dw.com/rdf/rss-en-eu"; } ];
                      }
                      {
                        type = "rss";
                        title = "DW: Science";
                        style = "vertical-list";
                        single-line-titles = true;
                        limit = 25;
                        cache = "1h";
                        collapse-after = 10;
                        feeds = [ { url = "https://rss.dw.com/rdf/rss-en-science"; } ];
                      }
                      {
                        type = "rss";
                        title = "DW: Environment";
                        style = "vertical-list";
                        single-line-titles = true;
                        limit = 25;
                        cache = "1h";
                        collapse-after = 10;
                        feeds = [ { url = "https://rss.dw.com/rdf/rss-en-environment"; } ];
                      }
                    ];
                  }
                ];
              }
            ];
            name = "Home";
          }
        ];
        server = {
          port = 3699;
        };
      };
    };
  };
}
