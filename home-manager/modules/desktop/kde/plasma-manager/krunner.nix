{
  programs.plasma = {
    krunner = {
      activateWhenTypingOnDesktop = true;
      historyBehavior = "enableAutoComplete";
      position = "center";
      shortcuts.launch = "Meta+Space";
      shortcuts.runCommandOnClipboard = "Meta+Shift+Space";
    };

    configFile.krunnerrc = {
      Plugins = {
        krunner_appstreamEnabled = false;
        krunner_konsoleprofilesEnabled = false;
        plasma-runner-neochatEnabled = true;
      };

      "Plugins/Favorites"."plugins" = "krunner_services,krunner_bookmarksrunner,krunner_systemsettings";

      "Runners/krunner_charrunner" = {
        "aliases" = "";
        "codes" = "";
        "triggerWord" = "#";
      };

      "Runners/krunner_kill" = {
        "sorting" = 1;
        "triggerWord" = "kill";
        "useTriggerWord" = true;
      };
    };
  };
}
