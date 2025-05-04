{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.drakolis.media;

  mediaPackages = with pkgs; [
    krita
    inkscape-with-extensions
  ];

  photoMediaPackages = with pkgs; [
    digikam
    rawtherapee
  ];

  videoRecordingMediaPackages = with pkgs; [
    obs-studio
  ];

  videoEditingMediaPackages = with pkgs; [
    kdePackages.kdenlive
  ];

  _3DMediaPackages = with pkgs; [
    blender
  ];

  desiredMediaPackages =
    mediaPackages
    ++ lib.optionals cfg.enablePhoto photoMediaPackages
    ++ lib.optionals cfg.enableVideoRecording videoRecordingMediaPackages
    ++ lib.optionals cfg.enableVideoEditing videoEditingMediaPackages
    ++ lib.optionals cfg.enable3D _3DMediaPackages;
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
      enable3D = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enable 3D modelling and printing software for this user.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = desiredMediaPackages;
  };
}
