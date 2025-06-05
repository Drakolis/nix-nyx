{
  programs.kate = {
    enable = true;
    package = null;
    editor = {
      brackets = {
        automaticallyAddClosing = true;
        # flashMatching = true;
        highlightMatching = true;
      };
      font = {
        family = "JetBrainsMono Nerd Font";
        pointSize = 11;
      };
      indent = {
        autodetect = true;
        backspaceDecreaseIndent = true;
        replaceWithSpaces = true;
        showLines = true;
        tabFromEverywhere = true;
        undoByShiftTab = true;
        width = 2;
      };
      tabWidth = 2;
      theme.name = "";
    };
    # Kate LSP!
    # lsp.customServers = "";
    ui.colorScheme = "";
  };

  programs.plasma.configFile.katerc = {
    BuildConfig = {
      AllowedCommandLines = "";
      AutoSwitchToOutput = true;
      BlockedCommandLines = "";
      UseDiagnosticsOutput = true;
    };
    CTags = {
      GlobalCommand = "ctags -R --c++-types=+px --extra=+q --excmd=pattern --exclude=Makefile --exclude=.";
      GlobalNumTargets = 0;
    };
    ColorPicker = {
      HexLengths = "3,6";
      NamedColors = true;
      PreviewAfterColor = true;
    };
    ColoredBrackets = {
      color1 = "#ee99a0";
      color2 = "#eed49f";
      color3 = "#a6da95";
      color4 = "#7dc4e4";
      color5 = "#b7bdf8";
    };
    "General" = {
      "Allow Tab Scrolling" = true;
      "Auto Hide Tabs" = false;
      "Close After Last" = false;
      "Close documents with window" = true;
      "Cycle To First Tab" = true;
      "Days Meta Infos" = 30;
      "Diagnostics Limit" = 12000;
      "Diff Show Style" = 0;
      "Elide Tab Text" = false;
      "Enable Context ToolView" = false;
      "Expand Tabs" = false;
      "Icon size for left and right sidebar buttons" = 32;
      "Modified Notification" = false;
      "Mouse back button action" = 0;
      "Mouse forward button action" = 0;
      "Open New Tab To The Right Of Current" = false;
      "Output History Limit" = 100;
      "Output With Date" = false;
      "Recent File List Entry Count" = 10;
      "Restore Window Configuration" = true;
      "SDI Mode" = false;
      "Save Meta Infos" = true;
      "Session Manager Sort Column" = 0;
      "Session Manager Sort Order" = 0;
      "Show Full Path in Title" = false;
      "Show Menu Bar" = true;
      "Show Status Bar" = true;
      "Show Symbol In Navigation Bar" = true;
      "Show Tab Bar" = true;
      "Show Tabs Close Button" = true;
      "Show Url Nav Bar" = true;
      "Show output view for message type" = 1;
      "Show text for left and right sidebar" = false;
      "Show welcome view for new window" = true;
      "Startup Session" = "last";
      "Stash new unsaved files" = true;
      "Stash unsaved file changes" = true;
      "Sync section size with tab positions" = false;
      "Tab Double Click New Document" = true;
      "Tab Middle Click Close Document" = true;
      "Tabbar Tab Limit" = 0;
    };
    "KTextEditor Document" = {
      "Allow End of Line Detection" = true;
      "Auto Detect Indent" = true;
      "Auto Reload If State Is In Version Control" = true;
      "Auto Save" = false;
      "Auto Save Interval" = 0;
      "Auto Save On Focus Out" = false;
      "BOM" = false;
      "Backup Local" = false;
      "Backup Prefix" = "";
      "Backup Remote" = false;
      "Backup Suffix" = "~";
      "Camel Cursor" = true;
      "Encoding" = "UTF-8";
      "End of Line" = 0;
      "Indent On Backspace" = true;
      "Indent On Tab" = true;
      "Indent On Text Paste" = true;
      "Indentation Mode" = "normal";
      "Indentation Width" = 2;
      "Keep Extra Spaces" = false;
      "Line Length Limit" = 10000;
      "Newline at End of File" = true;
      "On-The-Fly Spellcheck" = true;
      "Overwrite Mode" = false;
      "PageUp/PageDown Moves Cursor" = false;
      "Remove Spaces" = 1;
      "ReplaceTabsDyn" = true;
      "Show Spaces" = 0;
      "Show Tabs" = true;
      "Smart Home" = true;
      "Swap Directory" = "";
      "Swap File Mode" = 1;
      "Swap Sync Interval" = 15;
      "Trailing Marker Size" = 1;
      "Use Editor Config" = true;
      "Word Wrap" = false;
      "Word Wrap Column" = 80;
    };
    "KTextEditor Editor" = {
      "Encoding Prober Type" = 1;
      "Fallback Encoding" = "cp 1251";
    };
    "KTextEditor Renderer" = {
      "Animate Bracket Matching" = false;
      "Line Height Multiplier" = 1;
      "Show Whole Bracket Expression" = false;
      "Word Wrap Marker" = false;
    };
    "KTextEditor View" = {
      "Allow Mark Menu" = true;
      "Auto Brackets" = true;
      "Auto Center Lines" = 0;
      "Auto Completion" = true;
      "Auto Completion Preselect First Entry" = true;
      "Backspace Remove Composed Characters" = false;
      "Bookmark Menu Sorting" = 0;
      "Cycle Through Bookmarks" = true;
      "Default Mark Type" = 1;
      "Dynamic Word Wrap" = false;
      "Dynamic Word Wrap Align Indent" = 80;
      "Dynamic Word Wrap At Static Marker" = false;
      "Dynamic Word Wrap Indicators" = 1;
      "Dynamic Wrap not at word boundaries" = false;
      "Enable Accessibility" = true;
      "Enable Tab completion" = false;
      "Enter To Insert Completion" = true;
      "Fold First Line" = false;
      "Folding Bar" = true;
      "Folding Preview" = true;
      "Icon Bar" = false;
      "Input Mode" = 0;
      "Keyword Completion" = true;
      "Line Modification" = true;
      "Line Numbers" = true;
      "Max Clipboard History Entries" = 20;
      "Maximum Search History Size" = 100;
      "Mouse Paste At Cursor Position" = false;
      "Multiple Cursor Modifier" = 134217728;
      "Persistent Selection" = false;
      "Scroll Bar Marks" = false;
      "Scroll Bar Mini Map All" = true;
      "Scroll Bar Mini Map Width" = 60;
      "Scroll Bar MiniMap" = true;
      "Scroll Bar Preview" = true;
      "Scroll Past End" = false;
      "Search/Replace Flags" = 140;
      "Shoe Line Ending Type in Statusbar" = false;
      "Show Documentation With Completion" = true;
      "Show File Encoding" = true;
      "Show Folding Icons On Hover Only" = true;
      "Show Line Count" = true;
      "Show Scrollbars" = 0;
      "Show Statusbar Dictionary" = true;
      "Show Statusbar Highlighting Mode" = true;
      "Show Statusbar Input Mode" = true;
      "Show Statusbar Line Column" = true;
      "Show Statusbar Tab Settings" = true;
      "Show Word Count" = false;
      "Smart Copy Cut" = true;
      "Statusbar Line Column Compact Mode" = true;
      "Text Drag And Drop" = true;
      "User Sets Of Chars To Enclose Selection" = "";
      "Vi Input Mode Steal Keys" = false;
      "Vi Relative Line Numbers" = false;
      "Word Completion" = true;
      "Word Completion Minimal Word Length" = 3;
      "Word Completion Remove Tail" = true;
    };
    "KateSQLPlugin"."SaveConnections" = true;
    "KateSQLPlugin/OutputCustomization/blob" = {
      "backgroundColor" = "30,30,46";
      "font" = "JetBrainsMono Nerd Font,11,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
      "foregroundColor" = "205,214,244";
    };
    "KateSQLPlugin/OutputCustomization/bool" = {
      "backgroundColor" = "30,30,46";
      "font" = "JetBrainsMono Nerd Font,11,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
      "foregroundColor" = "205,214,244";
    };
    "KateSQLPlugin/OutputCustomization/datetime" = {
      "backgroundColor" = "30,30,46";
      "font" = "JetBrainsMono Nerd Font,11,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
      "foregroundColor" = "205,214,244";
    };
    "KateSQLPlugin/OutputCustomization/null" = {
      "backgroundColor" = "30,30,46";
      "font" = "JetBrainsMono Nerd Font,11,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
      "foregroundColor" = "205,214,244";
    };
    "KateSQLPlugin/OutputCustomization/number" = {
      "backgroundColor" = "30,30,46";
      "font" = "JetBrainsMono Nerd Font,11,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
      "foregroundColor" = "205,214,244";
    };
    "KateSQLPlugin/OutputCustomization/text" = {
      "backgroundColor" = "30,30,46";
      "font" = "JetBrainsMono Nerd Font,11,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
      "foregroundColor" = "205,214,244";
    };
    Konsole = {
      AutoSyncronizeMode = 0;
      KonsoleEscKeyBehaviour = false;
      KonsoleEscKeyExceptions = "vi,vim,nvim,git";
      RemoveExtension = false;
      RunPrefix = "";
      SetEditor = true;
    };
    filetree = {
      editShade = "183,220,246";
      listMode = false;
      middleClickToClose = false;
      shadingEnabled = true;
      showCloseButton = false;
      showFullPathOnRoots = false;
      showToolbar = true;
      sortRole = 0;
      viewShade = "211,190,222";
    };
    "lspclient" = {
      AllowedServerCommandLines = "/home/drakolis/.nix-profile/bin/lua-language-server,/home/drakolis/.nix-profile/bin/typescript-language-server --stdio,/run/current-system/sw/bin/nil";
      AutoHover = true;
      AutoImport = true;
      BlockedServerCommandLines = "/home/drakolis/.nix-profile/bin/yaml-language-server --stdio";
      CompletionDocumentation = true;
      CompletionParens = true;
      Diagnostics = true;
      FormatOnSave = true;
      HighlightGoto = true;
      IncrementalSync = false;
      InlayHints = false;
      Messages = true;
      ReferencesDeclaration = true;
      SemanticHighlighting = true;
      ServerConfiguration = "";
      SignatureHelp = true;
      SymbolDetails = false;
      SymbolExpand = true;
      SymbolSort = false;
      SymbolTree = true;
      TypeFormatting = false;
    };
    project = {
      autoCMake = true;
      autorepository = "git";
      gitStatusDoubleClick = 3;
      gitStatusSingleClick = 1;
      index = false;
      indexDirectory = "";
      multiProjectCompletion = false;
      multiProjectGoto = false;
      restoreProjectsForSessions = true;
    };
  };
}
