{
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
                  channels = [
                    "UC0intLFzLaudFG-xAvUEO-A"
                    "UCT_AKsYn-zjTC12CjCyp3dw"
                    "UCHnj59g7jezwTy5GeL8EA_g"
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
}
