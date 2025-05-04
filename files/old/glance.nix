{
  services.glance = {
    enable = true;
    settings = {
      server = {
        port = 1701;
      };
      theme = {
        background-color = "240 21 15";
        contrast-multiplier = 1.2;
        primary-color = "10 56 91";
        positive-color = "115 54 76";
        negative-color = "343 81 75";
      };
      pages = [
        {
          name = "Mika's Dashboard";
          columns = [
            {
              size = "small";
              widgets = [
                { type = "calendar"; }
                {
                  type = "weather";
                  units = "metric";
                  hour-format = "24h";
                  location = "Berlin, Germany";
                }
                {
                  type = "weather";
                  units = "metric";
                  hour-format = "24h";
                  location = "Belo Horizonte, Brazil";
                }
                {
                  type = "weather";
                  units = "metric";
                  hour-format = "24h";
                  location = "Saint Petersburg, Russia";
                }
                {
                  type = "weather";
                  units = "metric";
                  hour-format = "24h";
                  location = "Yekaterinburg, Russia";
                }
              ];
            }
            {
              size = "full";
              widgets = [
                {
                  type = "search";
                  "search-engine" = "https://www.ecosia.org/search?q={QUERY}";
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
              ];
            }
            {
              size = "small";
              widgets = [
                {
                  type = "clock";
                  hour-format = "24h";
                  timezones = [
                    {
                      timezone = "America/Sao_Paulo";
                      label = "Belo Horizonte, Brazil";
                    }
                    {
                      timezone = "Europe/Moscow";
                      label = "Saint Petersburg, Russia";
                    }
                    {
                      timezone = "Asia/Yekaterinburg";
                      label = "Yekaterinburg, Russia";
                    }
                  ];
                }
              ];
            }
          ];
        }
      ];
    };
  };
}
