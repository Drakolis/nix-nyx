{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.drakolis.media;

  mediaPackages = with pkgs; [
    ente-desktop
    inkscape-with-extensions
    kid3
  ];

  photoMediaPackages = with pkgs; [
    krita
    digikam
    rawtherapee
  ];

  videoRecordingMediaPackages = with pkgs; [
    obs-studio
  ];

  videoEditingMediaPackages = with pkgs; [
    kdePackages.kdenlive
  ];

  _3DModellingMediaPackages = with pkgs; [
    blender
  ];

  _3DPrintingMediaPackages = with pkgs; [
    orca-slicer

    # CAD tools (optional)
    freecad
    openscad

    # Utilities
    meshlab
  ];

  desiredMediaPackages =
    mediaPackages
    ++ lib.optionals cfg.enablePhoto photoMediaPackages
    ++ lib.optionals cfg.enableVideoRecording videoRecordingMediaPackages
    ++ lib.optionals cfg.enableVideoEditing videoEditingMediaPackages
    ++ lib.optionals cfg.enable3DModelling _3DModellingMediaPackages
    ++ lib.optionals cfg.enable3DPrinting _3DPrintingMediaPackages;
in
with lib;
{
  options = {
    drakolis.media = {
      enable = mkOption {
        default = true;
        type = types.bool;
        description = ''
          Enable media software for this user.
        '';
      };
      enablePhoto = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enable photo managing software for this user.
        '';
      };
      enableVideoRecording = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enable video recording/streaming software for this user.
        '';
      };
      enableVideoEditing = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enable video editing software for this user.
        '';
      };
      enable3DModelling = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enable 3D modelling software for this user.
        '';
      };
      enable3DPrinting = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enable 3D printing software for this user.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = desiredMediaPackages;
  };
}
