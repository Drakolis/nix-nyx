{ config, pkgs, ... }:
let style = import ../constants/style.nix;
in {
  accounts.calendar = {
    # accounts.calendar.basePath
    basePath = "Documents/Calendars/";
    accounts = {
      MikaLocal = {
        name = "Mika: Local Calendar";
        primary = true;
        khal = {
          enable = false;
          addresses = [ "drakolis@WinterDragon" ];
          color = "#${style.colors.primary}";
        };
      };
      # MikaGmail = {
      #   khal = {
      #     enable = true;
      #     addresses = "mika.drakoli@gmail.com";
      #     color = style.colors.terminalGreen;
      #     remote = {};
      #   };
      # };
      # MikaiCloud = {
      #   khal = {
      #     enable = true;
      #     addresses = "drakoli@icloud.com";
      #     color = style.colors.terminalCyan;
      #     remote = {};
      #   };
      # };
      # MikaWork = {
      #   khal = {
      #     enable = true;
      #     addresses = "drakoli@icloud.com";
      #     color = style.colors.critical;
      #     remote = {};
      #   };
      # };
    };
  };

  programs.khal = {
    enable = false;
    locale = {
      firstweekday = 0;
      weeknumbers = "left";
    };
    settings = {
      palette = {
        header = "'', '', '', '#121233', '#656599'";
        footer = "'', '', '', '#121233', '#656599'";
        line = "'', '', '', '#121233', '#656599'";
        alt = "'', '', '', '#121233', '#656599'";
        bright = "'', '', '', '#121233', '#656599'";
        list = "'', '', '', '#121233', '#656599'";
        "list focused" = "'', '', '', '#121233', '#656599'";
        edit = "'', '', '', '#121233', '#656599'";
        "edit focus" = "'', '', '', '#121233', '#656599'";
        button = "'', '', '', '#121233', '#656599'";
        "button focused" = "'', '', '', '#121233', '#656599'";
        "reveal focus" = "'', '', '', '#121233', '#656599'";
        "today focus" = "'', '', '', '#121233', '#656599'";
        today = "'', '', '', '#121233', '#656599'";
        "date header" = "'', '', '', '#121233', '#656599'";
        "date header focus" = "'', '', '', '#121233', '#656599'";
        "date header selected " = "'', '', '', '#121233', '#656599'";
        dayname = "'', '', '', '#121233', '#656599'";
        monthname = "'', '', '', '#121233', '#656599'";
        weeknumber_right = "'', '', '', '#121233', '#656599'";
        alert = "'', '', '', '#121233', '#656599'";
        mark = "'', '', '', '#121233', '#656599'";
        frame = "'', '', '', '#121233', '#656599'";
        "frame focus" = "'', '', '', '#121233', '#656599'";
        "frame focus color" = "'', '', '', '#121233', '#656599'";
        "frame focus top" = "'', '', '', '#121233', '#656599'";
        eventcolumn = "'', '', '', '#121233', '#656599'";
        "eventcolumn focus" = "'', '', '', '#121233', '#656599'";
        calendar = "'', '', '', '#121233', '#656599'";
        "calendar focus" = "'', '', '', '#121233', '#656599'";
        editbx = "'', '', '', '#121233', '#656599'";
        editcp = "'', '', '', '#121233', '#656599'";
        popupbg = "'', '', '', '#121233', '#656599'";
        popupper = "'', '', '', '#121233', '#656599'";
        caption = "'', '', '', '#121233', '#656599'";
      };
    };
  };

  programs.khard = {
    enable = true;
    settings = { };
  };
}
