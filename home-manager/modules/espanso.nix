{
  pkgs,
  ...
}:
{
  services.espanso = {
    waylandSupport = true;
    enable = true;
    package = pkgs.espanso-wayland;
    configs = {
      default = {
        search_shortcut = "ALT+META+SPACE";
        search_trigger = ":wtf";
        show_icon = true;
        show_notifications = true;
        keyboard_layout = {
          layout = "nz";
        };
      };
      nvim = {
        filter_exec = "nvim";
      };
    };
    matches = {
      base = {
        matches = [
          {
            trigger = ":now";
            replace = "{{currentdate}} {{currenttime}}";
          }
          {
            trigger = ":gm";
            replace = "Good morning. ";
          }
          {
            trigger = ":gmw";
            replace = "Good morning. I hope you are doing well. ";
          }
          {
            trigger = ":omw";
            replace = "On my way";
          }
          {
            trigger = ":mzp";
            replace = "mika.zimina@pm.me";
          }
          {
            trigger = ":mdg";
            replace = "mika.drakolis@gmail.com";
          }
          {
            trigger = ":mzw";
            replace = "mika.zimina@bonial.com";
          }
          {
            trigger = ":eof";
            replace = "Best regards,\nMika";
          }
          {
            regex = ":hi\\((?P<person>.*)\\)";
            replace = "Hi {{person}}!";
          }
        ];
      };
      global_vars = {
        global_vars = [
          {
            name = "currentdate";
            type = "date";
            params = {
              format = "%d.%m.%Y";
            };
          }
          {
            name = "currenttime";
            type = "date";
            params = {
              format = "%R";
            };
          }
        ];
      };
    };
  };
}
