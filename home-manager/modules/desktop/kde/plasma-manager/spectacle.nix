{
  programs.plasma = {
    spectacle.shortcuts = {
      captureActiveWindow = "Meta+Print";
      captureCurrentMonitor = "";
      captureEntireDesktop = "Shift+Print";
      captureRectangularRegion = "Print";
      captureWindowUnderCursor = "";
      launch = "Meta+Shift+Print";
      launchWithoutCapturing = "";
      recordRegion = "Ctrl+Print";
      recordScreen = "Ctrl+Shift+Print";
      recordWindow = "Meta+Ctrl+Print";
    };

    configFile.spectaclerc = {
      Annotations = {
        annotationToolType = 10;
        freehandStrokeColor = "243,139,168";
        highlighterStrokeColor = "249,226,175";
        lineStrokeColor = "243,139,168";
        arrowStrokeColor = "243,139,168";
        numberFillColor = "245,189,230";
        numberFontColor = "24,25,38";
        textFontColor = "205,214,244";
      };
      ImageSave.translatedScreenshotsFolder = "Screenshots";
      VideoSave.translatedScreencastsFolder = "Screencasts";
    };
  };
}
