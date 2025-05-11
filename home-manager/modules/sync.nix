{ pkgs, ... }:
{
  home.packages = with pkgs; [
    vdirsyncer
    rclone
  ];

  services.syncthing = {
    enable = true;
    settings = {
      gui = {
        user = "drakolis";
      };
      devices = {
        "YDdraigGoch" = {
          id = "NHJSCOU-DUNYOC3-ZSMG4ZF-IKWJZOF-Y2DKF2V-2MOWFU4-EXZJRG7-PP235AO";
        };
        "WinterDragon" = {
          id = "J3ABNVA-VXV3CBZ-FWYWKWY-UXZNNKW-SSNSCLZ-KTU35OS-PE6YUHR-EIEOCA5";
        };
        "mb-H02L4YFQ6P" = {
          id = "ZZKPN74-4BCOU4T-6K4IXL3-IKL4DDF-7B3JIDX-2LWZWGU-OPYYJJS-SEDALAZ";
        };
      };
      folders = {
        "Drakolis Files" = {
          path = "~/Shared";
          devices = [
            "YDdraigGoch"
            "WinterDragon"
            "mb-H02L4YFQ6P"
          ];
        };
      };
    };
  };
}
