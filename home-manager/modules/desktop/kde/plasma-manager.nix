{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.drakolis.kde;
in
with lib;
{
  options = {
    drakolis.kde = {
      isLaptop = mkOption {
        default = true;
        type = types.bool;
        description = ''
          Run a lighter config and lower power consumption.
        '';
      };
      isServer = mkOption {
        default = true;
        type = types.bool;
        description = ''
          Will turn off the sleep mode entirely.
        '';
      };
    };
  };

  config = {
    programs.okular = {
      enable = true;
      package = null;
    };

    programs.plasma = {
      enable = true;
      # https://github.com/nix-community/plasma-manager/blob/trunk/examples/home.nix
      # https://nix-community.github.io/plasma-manager/options.xhtml

      desktop.widgets = [ ];

      fonts = {
        fixedWidth = {
          family = "JetBrainsMono Nerd Font";
          pointSize = 11;
        };
        general = {
          family = "Ubuntu Sans";
          pointSize = 11;
        };
        menu = {
          family = "Ubuntu Sans";
          pointSize = 11;
        };
        small = {
          family = "Ubuntu Sans";
          pointSize = 9;
        };
        toolbar = {
          family = "Ubuntu Sans";
          pointSize = 11;
        };
        windowTitle = {
          family = "Ubuntu Sans";
          pointSize = 11;
          weight = "medium";
        };
      };

      input.keyboard = {
        layouts = [
          {
            layout = "nz";
          }
          {
            layout = "ru";
          }
        ];

        numlockOnStartup = "on";

        options = [
          "grp:ctrl_space_toggle"
          "compose:sclk"
          "compose:ralt"
          "apple:alupckeys"
        ];

        switchingPolicy = "window";
      };

      input.touchpads = [
        {
          name = "SynPS/2 Synaptics TouchPad";
          productId = "0007";
          vendorId = "0002";
          disableWhileTyping = true;
          enable = true;
          naturalScroll = true;
        }
      ];

      session = {
        sessionRestore = {
          restoreOpenApplicationsOnLogin = "startWithEmptySession";
          excludeApplications = [ ];
        };
        general.askForConfirmationOnLogout = true;
      };

      windows = {
        allowWindowsToRememberPositions = true;
      };

      workspace = {
        enableMiddleClickPaste = false;
      };

      configFile.kwalletrc = {
        Wallet = {
          "First Use" = false;
          "Enabled" = true;

          "Close When Idle" = false;
          "Close on Screensaver" = false;
          "Leave Open" = true;
          "Idle Timeout" = 10;

          "Default Wallet" = "kdewallet";
          "Use One Wallet" = true;

          "Launch Manager" = false;
          "Leave Manager Open" = false;

          "Prompt on Open" = true;
        };
        "org.freedesktop.secrets"."apiEnabled" = true;
      };

      # configFile = {
      #   "baloofilerc"."General"."dbVersion" = 2;
      #   "baloofilerc"."General"."exclude filters" =
      #     "*~,*.part,*.o,*.la,*.lo,*.loT,*.moc,moc_*.cpp,qrc_*.cpp,ui_*.h,cmake_install.cmake,CMakeCache.txt,CTestTestfile.cmake,libtool,config.status,confdefs.h,autom4te,conftest,confstat,Makefile.am,*.gcode,.ninja_deps,.ninja_log,build.ninja,*.csproj,*.m4,*.rej,*.gmo,*.pc,*.omf,*.aux,*.tmp,*.po,*.vm*,*.nvram,*.rcore,*.swp,*.swap,lzo,litmain.sh,*.orig,.histfile.*,.xsession-errors*,*.map,*.so,*.a,*.db,*.qrc,*.ini,*.init,*.img,*.vdi,*.vbox*,vbox.log,*.qcow2,*.vmdk,*.vhd,*.vhdx,*.sql,*.sql.gz,*.ytdl,*.tfstate*,*.class,*.pyc,*.pyo,*.elc,*.qmlc,*.jsc,*.fastq,*.fq,*.gb,*.fasta,*.fna,*.gbff,*.faa,po,CVS,.svn,.git,_darcs,.bzr,.hg,CMakeFiles,CMakeTmp,CMakeTmpQmake,.moc,.obj,.pch,.uic,.npm,.yarn,.yarn-cache,__pycache__,node_modules,node_packages,nbproject,.terraform,.venv,venv,core-dumps,lost+found";
      #   "baloofilerc"."General"."exclude filters version" = 9;
      #   "dolphinrc"."ContentDisplay"."UseShortRelativeDates" = false;
      #   "dolphinrc"."DetailsMode"."PreviewSize" = 22;
      #   "dolphinrc"."ExtractDialog"."2048x1152 screen: Height" = 576;
      #   "dolphinrc"."ExtractDialog"."2048x1152 screen: Width" = 1320;
      #   "dolphinrc"."ExtractDialog"."DirHistory[$e]" = "$HOME/Applications/";
      #   "dolphinrc"."General"."BrowseThroughArchives" = true;
      #   "dolphinrc"."General"."ShowFullPath" = true;
      #   "dolphinrc"."General"."UseTabForSwitchingSplitView" = true;
      #   "dolphinrc"."General"."ViewPropsTimestamp" = "2025,2,12,19,7,30.472";
      #   "dolphinrc"."InformationPanel"."dateFormat" = "ShortFormat";
      #   "dolphinrc"."KFileDialog Settings"."Places Icons Auto-resize" = false;
      #   "dolphinrc"."KFileDialog Settings"."Places Icons Static Size" = 22;
      #   "dolphinrc"."PreviewSettings"."Plugins" =
      #     "appimagethumbnail,audiothumbnail,blenderthumbnail,comicbookthumbnail,cursorthumbnail,djvuthumbnail,ebookthumbnail,exrthumbnail,directorythumbnail,fontthumbnail,imagethumbnail,calligraimagethumbnail,jpegthumbnail,kraorathumbnail,windowsexethumbnail,windowsimagethumbnail,mobithumbnail,opendocumentthumbnail,calligrathumbnail,gsthumbnail,rawthumbnail,svgthumbnail,ffmpegthumbs";
      #   "dolphinrc"."Search"."Location" = "Everywhere";
      #   "dolphinrc"."VersionControl"."enabledPlugins" = "Git";
      #   "kactivitymanagerdrc"."activities"."62a560c1-414c-48e4-b51c-0b5b77c69eef" =
      #     "Do not track me";
      #   "kactivitymanagerdrc"."activities"."775e9937-87ae-430c-927b-5e2e1d8cbcf1" =
      #     "Default";
      #   "kactivitymanagerdrc"."activities"."c3b67045-c8a8-4648-976f-68be603203d8" =
      #     "Caffeine";
      #   "kactivitymanagerdrc"."activities-descriptions"."c3b67045-c8a8-4648-976f-68be603203d8" =
      #     "Moscow never sleeps";
      #   "kactivitymanagerdrc"."activities-icons"."62a560c1-414c-48e4-b51c-0b5b77c69eef" =
      #     "view-private";
      #   "kactivitymanagerdrc"."activities-icons"."775e9937-87ae-430c-927b-5e2e1d8cbcf1" =
      #     "folder-windows-symbolic";
      #   "kactivitymanagerdrc"."activities-icons"."c3b67045-c8a8-4648-976f-68be603203d8" =
      #     "accept_time_event";
      #   "kactivitymanagerdrc"."main"."currentActivity" =
      #     "775e9937-87ae-430c-927b-5e2e1d8cbcf1";
      #   "kded5rc"."Module-browserintegrationreminder"."autoload" = false;
      #   "kded5rc"."Module-device_automounter"."autoload" = false;
      #   "kdeglobals"."DirSelect Dialog"."DirSelectDialog Size" = "862,591";
      #   "kdeglobals"."General"."LastUsedCustomAccentColor" = "146,110,228";
      #   "kdeglobals"."General"."UseSystemBell" = true;
      #   "kdeglobals"."General"."XftHintStyle" = "hintslight";
      #   "kdeglobals"."General"."XftSubPixel" = "rgb";
      #   "kdeglobals"."KDE"."ShowDeleteCommand" = false;
      #   "kdeglobals"."KDE"."widgetStyle" = "Breeze";
      #   "kdeglobals"."KFileDialog Settings"."Allow Expansion" = false;
      #   "kdeglobals"."KFileDialog Settings"."Automatically select filename extension" =
      #     true;
      #   "kdeglobals"."KFileDialog Settings"."Breadcrumb Navigation" = true;
      #   "kdeglobals"."KFileDialog Settings"."Decoration position" = 2;
      #   "kdeglobals"."KFileDialog Settings"."LocationCombo Completionmode" = 5;
      #   "kdeglobals"."KFileDialog Settings"."PathCombo Completionmode" = 5;
      #   "kdeglobals"."KFileDialog Settings"."Show Bookmarks" = false;
      #   "kdeglobals"."KFileDialog Settings"."Show Full Path" = false;
      #   "kdeglobals"."KFileDialog Settings"."Show Inline Previews" = true;
      #   "kdeglobals"."KFileDialog Settings"."Show Preview" = false;
      #   "kdeglobals"."KFileDialog Settings"."Show Speedbar" = true;
      #   "kdeglobals"."KFileDialog Settings"."Show hidden files" = true;
      #   "kdeglobals"."KFileDialog Settings"."Sort by" = "Name";
      #   "kdeglobals"."KFileDialog Settings"."Sort directories first" = true;
      #   "kdeglobals"."KFileDialog Settings"."Sort hidden files last" = false;
      #   "kdeglobals"."KFileDialog Settings"."Sort reversed" = false;
      #   "kdeglobals"."KFileDialog Settings"."Speedbar Width" = 270;
      #   "kdeglobals"."KFileDialog Settings"."View Style" = "DetailTree";
      #   "kdeglobals"."KShortcutsDialog Settings"."Dialog Size" = "902,480";
      #   "kdeglobals"."PreviewSettings"."EnableRemoteFolderThumbnail" = false;
      #   "kdeglobals"."PreviewSettings"."MaximumRemoteSize" = 0;
      #   "kdeglobals"."WM"."activeBackground" = "30,30,46";
      #   "kdeglobals"."WM"."activeBlend" = "205,214,244";
      #   "kdeglobals"."WM"."activeFont" =
      #     "Noto Sans,11,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
      #   "kdeglobals"."WM"."activeForeground" = "205,214,244";
      #   "kdeglobals"."WM"."inactiveBackground" = "17,17,27";
      #   "kdeglobals"."WM"."inactiveBlend" = "166,173,200";
      #   "kdeglobals"."WM"."inactiveForeground" = "166,173,200";
      #   "kiorc"."Confirmations"."ConfirmDelete" = true;
      #   "kiorc"."Confirmations"."ConfirmEmptyTrash" = true;
      #   "kiorc"."Confirmations"."ConfirmTrash" = false;
      #   "kiorc"."Executable scripts"."behaviourOnLaunch" = "execute";
      #   "kscreenlockerrc"."Greeter/Wallpaper/org.kde.image/General"."Image" =
      #     "/home/drakolis/Pictures/shaded_landscape.png";
      #   "kscreenlockerrc"."Greeter/Wallpaper/org.kde.image/General"."PreviewImage" =
      #     "/home/drakolis/Pictures/shaded_landscape.png";
      #   "kservicemenurc"."Show"."Play" = true;
      #   "kservicemenurc"."Show"."Print" = true;
      #   "kservicemenurc"."Show"."compressfileitemaction" = true;
      #   "kservicemenurc"."Show"."decrypt-view" = true;
      #   "kservicemenurc"."Show"."encrypt" = true;
      #   "kservicemenurc"."Show"."extractfileitemaction" = true;
      #   "kservicemenurc"."Show"."forgetfileitemaction" = true;
      #   "kservicemenurc"."Show"."installFont" = true;
      #   "kservicemenurc"."Show"."kactivitymanagerd_fileitem_linking_plugin" =
      #     true;
      #   "kservicemenurc"."Show"."kdeconnectfileitemaction" = true;
      #   "kservicemenurc"."Show"."kio-admin" = false;
      #   "kservicemenurc"."Show"."kompare" = true;
      #   "kservicemenurc"."Show"."makefileactions" = true;
      #   "kservicemenurc"."Show"."mountisoaction" = true;
      #   "kservicemenurc"."Show"."movetonewfolderitemaction" = true;
      #   "kservicemenurc"."Show"."runInKonsole" = true;
      #   "kservicemenurc"."Show"."slideshowfileitemaction" = true;
      #   "kservicemenurc"."Show"."tagsfileitemaction" = true;
      #   "kservicemenurc"."Show"."wallpaperfileitemaction" = true;
      #   "ktrashrc"."\\/home\\/drakolis\\/.local\\/share\\/Trash"."Days" = 7;
      #   "ktrashrc"."\\/home\\/drakolis\\/.local\\/share\\/Trash"."LimitReachedAction" =
      #     0;
      #   "ktrashrc"."\\/home\\/drakolis\\/.local\\/share\\/Trash"."Percent" = 10;
      #   "ktrashrc"."\\/home\\/drakolis\\/.local\\/share\\/Trash"."UseSizeLimit" =
      #     true;
      #   "ktrashrc"."\\/home\\/drakolis\\/.local\\/share\\/Trash"."UseTimeLimit" =
      #     false;
      #   "kuriikwsfilterrc"."General"."DefaultWebShortcut" = "ecosia";
      #   "kuriikwsfilterrc"."General"."EnableWebShortcuts" = true;
      #   "kuriikwsfilterrc"."General"."KeywordDelimiter" = "s";
      #   "kuriikwsfilterrc"."General"."PreferredWebShortcuts" =
      #     "youtube,wikit,yahoo,wikipedia,google";
      #   "kuriikwsfilterrc"."General"."UsePreferredWebShortcutsOnly" = false;

      # };
      # dataFile = {
      #   "kate/anonymous.katesession"."Document 0"."URL" =
      #     "file:///home/drakolis/.config/sops/age/keys.txt";
      #   "kate/anonymous.katesession"."Kate Plugins"."cmaketoolsplugin" = false;
      #   "kate/anonymous.katesession"."Kate Plugins"."compilerexplorer" = false;
      #   "kate/anonymous.katesession"."Kate Plugins"."eslintplugin" = true;
      #   "kate/anonymous.katesession"."Kate Plugins"."externaltoolsplugin" = true;
      #   "kate/anonymous.katesession"."Kate Plugins"."formatplugin" = true;
      #   "kate/anonymous.katesession"."Kate Plugins"."katebacktracebrowserplugin" =
      #     false;
      #   "kate/anonymous.katesession"."Kate Plugins"."katebuildplugin" = true;
      #   "kate/anonymous.katesession"."Kate Plugins"."katecloseexceptplugin" =
      #     false;
      #   "kate/anonymous.katesession"."Kate Plugins"."katecolorpickerplugin" =
      #     true;
      #   "kate/anonymous.katesession"."Kate Plugins"."katectagsplugin" = true;
      #   "kate/anonymous.katesession"."Kate Plugins"."katefilebrowserplugin" =
      #     false;
      #   "kate/anonymous.katesession"."Kate Plugins"."katefiletreeplugin" = true;
      #   "kate/anonymous.katesession"."Kate Plugins"."kategdbplugin" = false;
      #   "kate/anonymous.katesession"."Kate Plugins"."kategitblameplugin" = true;
      #   "kate/anonymous.katesession"."Kate Plugins"."katekonsoleplugin" = true;
      #   "kate/anonymous.katesession"."Kate Plugins"."kateprojectplugin" = true;
      #   "kate/anonymous.katesession"."Kate Plugins"."katereplicodeplugin" = false;
      #   "kate/anonymous.katesession"."Kate Plugins"."katesearchplugin" = true;
      #   "kate/anonymous.katesession"."Kate Plugins"."katesnippetsplugin" = false;
      #   "kate/anonymous.katesession"."Kate Plugins"."katesqlplugin" = false;
      #   "kate/anonymous.katesession"."Kate Plugins"."katesymbolviewerplugin" =
      #     false;
      #   "kate/anonymous.katesession"."Kate Plugins"."katexmlcheckplugin" = false;
      #   "kate/anonymous.katesession"."Kate Plugins"."katexmltoolsplugin" = false;
      #   "kate/anonymous.katesession"."Kate Plugins"."keyboardmacrosplugin" =
      #     false;
      #   "kate/anonymous.katesession"."Kate Plugins"."ktexteditorpreviewplugin" =
      #     false;
      #   "kate/anonymous.katesession"."Kate Plugins"."latexcompletionplugin" =
      #     false;
      #   "kate/anonymous.katesession"."Kate Plugins"."lspclientplugin" = true;
      #   "kate/anonymous.katesession"."Kate Plugins"."openlinkplugin" = false;
      #   "kate/anonymous.katesession"."Kate Plugins"."rainbowparens" = true;
      #   "kate/anonymous.katesession"."Kate Plugins"."rbqlplugin" = false;
      #   "kate/anonymous.katesession"."Kate Plugins"."tabswitcherplugin" = true;
      #   "kate/anonymous.katesession"."Kate Plugins"."textfilterplugin" = true;
      #   "kate/anonymous.katesession"."MainWindow0"."Active ViewSpace" = 0;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-H-Splitter" =
      #     "0,1249,0";
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-0-Bar-0-TvList" =
      #     "";
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-0-LastSize" =
      #     258;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-0-SectSizes" =
      #     0;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-0-Splitter" =
      #     1246;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-1-Bar-0-TvList" =
      #     "kateproject,kateprojectgit,lspclient_symbol_outline,kate_private_plugin_katefiletreeplugin";
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-1-LastSize" =
      #     269;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-1-SectSizes" =
      #     0;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-1-Splitter" =
      #     1246;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-2-Bar-0-TvList" =
      #     "";
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-2-LastSize" =
      #     200;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-2-SectSizes" =
      #     0;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-2-Splitter" =
      #     1249;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-3-Bar-0-TvList" =
      #     "output,diagnostics,kate_plugin_katesearch,kateprojectinfo,kate_private_plugin_katekonsoleplugin,kate_plugin_katebuildplugin,kate_plugin_katectagsplugin";
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-3-LastSize" =
      #     462;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-3-SectSizes" =
      #     0;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-3-Splitter" =
      #     894;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-Style" = 2;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-Sidebar-Visible" =
      #     true;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-diagnostics-Position" =
      #     3;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-diagnostics-Show-Button-In-Sidebar" =
      #     true;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-diagnostics-Visible" =
      #     false;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_plugin_katebuildplugin-Position" =
      #     3;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_plugin_katebuildplugin-Show-Button-In-Sidebar" =
      #     true;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_plugin_katebuildplugin-Visible" =
      #     false;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_plugin_katectagsplugin-Position" =
      #     3;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_plugin_katectagsplugin-Show-Button-In-Sidebar" =
      #     true;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_plugin_katectagsplugin-Visible" =
      #     false;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_plugin_katesearch-Position" =
      #     3;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_plugin_katesearch-Show-Button-In-Sidebar" =
      #     true;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_plugin_katesearch-Visible" =
      #     false;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_private_plugin_katefiletreeplugin-Position" =
      #     1;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_private_plugin_katefiletreeplugin-Show-Button-In-Sidebar" =
      #     true;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_private_plugin_katefiletreeplugin-Visible" =
      #     false;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_private_plugin_katekonsoleplugin-Position" =
      #     3;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_private_plugin_katekonsoleplugin-Show-Button-In-Sidebar" =
      #     true;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kate_private_plugin_katekonsoleplugin-Visible" =
      #     false;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateproject-Position" =
      #     1;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateproject-Show-Button-In-Sidebar" =
      #     true;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateproject-Visible" =
      #     false;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateprojectgit-Position" =
      #     1;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateprojectgit-Show-Button-In-Sidebar" =
      #     true;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateprojectgit-Visible" =
      #     false;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateprojectinfo-Position" =
      #     3;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateprojectinfo-Show-Button-In-Sidebar" =
      #     true;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-kateprojectinfo-Visible" =
      #     false;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-lspclient_symbol_outline-Position" =
      #     1;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-lspclient_symbol_outline-Show-Button-In-Sidebar" =
      #     true;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-lspclient_symbol_outline-Visible" =
      #     false;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-output-Position" =
      #     3;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-output-Show-Button-In-Sidebar" =
      #     true;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-ToolView-output-Visible" =
      #     false;
      #   "kate/anonymous.katesession"."MainWindow0"."Kate-MDI-V-Splitter" =
      #     "0,1246,0";
      #   "kate/anonymous.katesession"."MainWindow0 Settings"."WindowState" = 8;
      #   "kate/anonymous.katesession"."MainWindow0-Splitter 0"."Children" =
      #     "MainWindow0-ViewSpace 0";
      #   "kate/anonymous.katesession"."MainWindow0-Splitter 0"."Orientation" = 1;
      #   "kate/anonymous.katesession"."MainWindow0-Splitter 0"."Sizes" = 1249;
      #   "kate/anonymous.katesession"."MainWindow0-ViewSpace 0"."Active View" = 0;
      #   "kate/anonymous.katesession"."MainWindow0-ViewSpace 0"."Count" = 1;
      #   "kate/anonymous.katesession"."MainWindow0-ViewSpace 0"."Documents" = 0;
      #   "kate/anonymous.katesession"."MainWindow0-ViewSpace 0"."View 0" = 0;
      #   "kate/anonymous.katesession"."MainWindow0-ViewSpace 0 0"."CursorColumn" =
      #     0;
      #   "kate/anonymous.katesession"."MainWindow0-ViewSpace 0 0"."CursorLine" = 3;
      #   "kate/anonymous.katesession"."Open Documents"."Count" = 1;
      #   "kate/anonymous.katesession"."Open MainWindows"."Count" = 1;
      #   "kate/anonymous.katesession"."Plugin:katebuildplugin:MainWindow:0"."NumTargets" =
      #     0;
      #   "kate/anonymous.katesession"."Plugin:katebuildplugin:MainWindow:0"."ProjectTargetSetRow" =
      #     1;
      #   "kate/anonymous.katesession"."Plugin:katectagsplugin:MainWindow:0"."SessionDatabase" =
      #     "";
      #   "kate/anonymous.katesession"."Plugin:katectagsplugin:MainWindow:0"."SessionNumTargets" =
      #     0;
      #   "kate/anonymous.katesession"."Plugin:katectagsplugin:MainWindow:0"."TagsGenCMD" =
      #     "ctags -R --c++-types=+px --extra=+q --excmd=pattern --exclude=Makefile --exclude=.";
      #   "kate/anonymous.katesession"."Plugin:kateprojectplugin:"."projects" = "";
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."BinaryFiles" =
      #     false;
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."CurrentExcludeFilter" =
      #     "-1";
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."CurrentFilter" =
      #     "-1";
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."ExcludeFilters" =
      #     "";
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."ExpandSearchResults" =
      #     false;
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."Filters" =
      #     "";
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."FollowSymLink" =
      #     false;
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."HiddenFiles" =
      #     false;
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."MatchCase" =
      #     false;
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."Place" =
      #     1;
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."Recursive" =
      #     true;
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."Replaces" =
      #     "";
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."Search" =
      #     "";
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SearchAsYouTypeAllProjects" =
      #     true;
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SearchAsYouTypeCurrentFile" =
      #     true;
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SearchAsYouTypeFolder" =
      #     true;
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SearchAsYouTypeOpenFiles" =
      #     true;
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SearchAsYouTypeProject" =
      #     true;
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SearchDiskFiles" =
      #     "";
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SearchDiskFiless" =
      #     "";
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."SizeLimit" =
      #     128;
      #   "kate/anonymous.katesession"."Plugin:katesearchplugin:MainWindow:0"."UseRegExp" =
      #     false;
      # };
    };
  };
}
