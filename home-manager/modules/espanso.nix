{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  services.espanso = {
    waylandSupport = true;
    enable = true;
    package = pkgs.espanso-wayland;
    matches = {
      base = {
        matches = [
          {
            trigger = ":now";
            replace = "{{currentdate}} {{currenttime}}";
          }
          {
            trigger = ":gomo";
            replace = "Good morning. ";
          }
          {
            trigger = ":omw";
            replace = "On my way";
          }
          {
            regex = ":hi(?P<person>.*)\\.";
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
              format = "%d/%m/%Y";
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
